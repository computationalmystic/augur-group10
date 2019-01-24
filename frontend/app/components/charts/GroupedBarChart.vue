<template>
  <div ref="holder">
    <div class="groupedbarchart hidefirst invis">
      <vega-lite :spec="spec" :data="values"></vega-lite>
      <p> {{ chart }} </p>
    </div>
  </div>
</template>


<script>
import { mapState } from 'vuex'
import AugurStats from 'AugurStats'

export default {
  props: ['source', 'citeUrl', 'citeText', 'title', 'disableRollingAverage', 'alwaysByDate', 'data'],
  data() {
    return {
      values: []
    }
  },
  computed: {
        repo () {
      return this.$store.state.baseRepo
    },
    gitRepos () {
      return this.$store.state.gitRepo
    },
    period () {
      return this.$store.state.trailingAverage
    },
    earliest () {
      return this.$store.state.startDate
    },
    latest () {
      return this.$store.state.endDate
    },
    compare () {
      return this.$store.state.compare
    },
    comparedRepos () {
      return this.$store.state.comparedRepos
    },
    rawWeekly () {
      return this.$store.state.rawWeekly
    },
    showArea () {
      return this.$store.state.showArea
    },
    showTooltip () {
      return this.$store.state.showTooltip
    },
    showDetail () {
      return this.$store.state.showDetail
    },
    spec() {
      let config = {
          "$schema": "https://vega.github.io/schema/vega-lite/v3.json",
          "data": { "url": "data/population.json"},
          "transform": [
            {"filter": "datum.year == 2000"},
            {"calculate": "datum.sex == 2 ? 'Female' : 'Male'", "as": "gender"}
          ],
          "mark": "bar",
          "encoding": {
              "column": {
                "field": "age", "type": "ordinal"
              },
              "y": {
                "aggregate": "sum", "field": "people", "type": "quantitative",
                "axis": {"title": "population", "grid": false}
              },
              "x": {
                "field": "gender", "type": "nominal",
                "scale": {"rangeStep": 12},
                "axis": {"title": ""}
              },
              "color": {
                "field": "gender", "type": "nominal",
                "scale": {"range": ["#EA98D2", "#659CCA"]}
              }
          },
          "config": {
              "view": {"stroke": "transparent"},
              "axis": {"domainWidth": 1}
          }
      }

      // Get the repos we need
      let repos = []
      if (this.repo) {
        if (window.AugurRepos[this.repo])
          repos.push(window.AugurRepos[this.repo])
        else if (this.domain){
          let temp = window.AugurAPI.Repo({"gitURL": this.gitRepo})
          if (window.AugurRepos[temp])
            temp = window.AugurRepos[temp]
          else
            window.AugurRepos[temp] = temp
          repos.push(temp)
        }
        // repos.push(this.repo)
      } // end if (this.$store.repo)
      this.comparedRepos.forEach(function(repo) {
        repos.push(window.AugurRepos[repo])
      });
            /*
       * Takes a string like "commits,lines_changed:additions+deletions"
       * and makes it into an array of endpoints:
       *
       *   endpoints = ['commits','lines_changed']
       *
       * and a map of the fields wanted from those endpoints:
       *
       *   fields = {
       *     'lines_changed': ['additions', 'deletions']
       *   }
       */
      let endpoints = []
      let fields = {}
      this.source.split(',').forEach((endpointAndFields) => {
        let split = endpointAndFields.split(':')
        endpoints.push(split[0])
        if (split[1]) {
          fields[split[0]] = split[1].split('+')
        }
      })
      if (this.data) {
        processGitData(this.data)
      } else {
        console.log(repos, endpoints)
        window.AugurAPI.batchMapped(repos, endpoints).then((data) => {
          console.log("DATA", data)
          processData(data)
        }, () => {
          //this.renderError()
        }) // end batch request
      }

      $(this.$el).find('.showme, .hidefirst').removeClass('invis')
      $(this.$el).find('.stackedbarchart').removeClass('loader')

      let processGitData = (data) => {
        let repo = window.AugurAPI.Repo({ gitURL: this.repo })
        let dat = []
        repo.changesByAuthor().then((changes) => {
          console.log("CHANGES", changes)
          dat.push(changes)
        })
        console.log(dat)
      }
      let defaultProcess = (obj, key, field) => {
            let d = null
            if (typeof(field) == "string") field = [field]

            d = AugurStats.convertKey(obj[key], key, 'value')


            d = AugurStats.convertDates(d, this.earliest, this.latest, 'date')

            return d
          }

      let processData = (data) => {
        console.log(data[this.repo], Object.keys(data[this.repo])[0])
        let d = defaultProcess(data[this.repo], Object.keys(data[this.repo])[0], 'value')
        console.log(d)
      }
      return config
    },
  }
}

</script>
