<template>
  <div ref="holder">
      <h3>NEW TABLE FOR NEW METRICS</h3>
      <table class="lines-of-code-table">
        <thead>
          <tr>Project/Group ID: </tr>
          <tr>Metric: </tr>
          <tr>
            <th>Project</th>
            <th>Repo</th>
            <th>Start</th>
            <th>End</th>
            <th>High</th>
            <th>Low</th>
            <th>%</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="repo in repos.slice(0, 10)">
            <td>{{ contributor.author_email }}</td>
            <td v-if="!setYear" v-for="year in years">{{ (contributor[year]) ? contributor[year].additions || 0 : 0}}</td>
            <td v-if="setYear" v-for="month in monthDecimals">{{ (contributor[setYear + '-' + month]) ? contributor[setYear + '-' + month].additions || 0 : 0 }}</td>
            <td v-if="!setYear">{{ contributor.additions }}</td>
            <td v-if="setYear">{{ (contributor[setYear]) ? contributor[setYear].additions || 0 : 0}}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>

  <script>
export default {
  props: ['source', 'citeUrl', 'citeText', 'title'],
  data() {
    return {
      repos: []
    }
  },
  computed: {
    repo() {
      return this.$store.state.baseRepo
    },
    comparedRepos () {
      return this.$store.state.comparedRepos
    },
    chart() {

      if (this.data) {
        processData(this.data)
      } else {
        
        window.AugurAPI.batchMapped(repos, endpoints).then((data) => {
          processData(data)
        }, () => {
          //this.renderError()
        }) // end batch request
      }

      let processData = (data) => {
        // Get the repos we need
        console.log(data)
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
        }
        this.comparedRepos.forEach(function(repo) {
          repos.push(window.AugurRepos[repo])
        });
        this.repos = repos
      }
    }
  }
}

</script>
