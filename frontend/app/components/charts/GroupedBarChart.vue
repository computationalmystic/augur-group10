<template>
  <div ref="holder">
    <div class="groupedbarchart">
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
    gitRepo () {
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
          "config": {
              // "view": {"stroke": "transparent"},
              // "axis": {"domainWidth": 1}
          },
          "title": {
            "text": this.title,
            // "offset": 55
            "offset": 10
          },
          // "width": 520,
          // "height": 450,
          "layer": [
            {
              "transform": [

              ],
              "mark": "bar",
              "encoding": {
                  "row": {
                     "field": "name", "type": "ordinal",
                    "scale": {"rangeStep": 12},
                    "axis": {"title": ""}
                  },
                  "x": {
                    "field": "net", "type": "quantitative",
                  },
                  "y": {
                    "field": "name", "type": "ordinal",
                    "scale": {"rangeStep": 12},
                    "axis": {"title": ""}
                  },
                  "color": {
                    "field": "repo", "type": "nominal",
                    "scale": {"range": ["#EA98D2", "#659CCA"]}
                  }
              },
            },
          ]
      }

      // Get the repos we need
      let repos = []
      if (this.gitRepo) {
        repos.push(window.AugurAPI.Repo({ gitURL: this.gitRepo }))
        // else if (this.domain){
        //   let temp = window.AugurAPI.Repo({"gitURL": this.gitRepo})
        //   if (window.AugurRepos[temp])
        //     temp = window.AugurRepos[temp]
        //   else
        //     window.AugurRepos[temp] = temp
        //   repos.push(temp)
        // }
      } // end if (this.$store.repo)
      // this.comparedRepos.forEach(function(repo) {
      //   repos.push(window.AugurRepos[repo])
      // });
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
        let repo = window.AugurAPI.Repo({ gitURL: this.gitRepo })
        repo[this.source]().then((data) => {
          console.log("batch data", data)
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
          dat.push(changes)
        })
      }
      let defaultProcess = (obj, key) => {
            let d = null
            if (typeof(field) == "string") field = [field]
            d = AugurStats.convertKey(obj[key], key)
            return d
          }

      let processData = (data) => {
        console.log(repos, data, "CHECK")
        repos.forEach((repo) => {
          // let d = defaultProcess(data[repo], Object.keys(data[this.repo])[0])
          // d[0].repo = repo.gitURL ? repo.gitURL : repo.githubURL
          // this.values.push(d[0])
          console.log("repo data", data)
          this.values = data
        })
      }
      return config
    },
  }
}

</script>
