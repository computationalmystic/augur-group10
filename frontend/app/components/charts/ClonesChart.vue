<template>
  <div ref="holder">
      <h3>Number of Clones</h3>
      <table class="clones-table">
        <thead>
          <tr>
            <th>Total</th>
            <th>Unique</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>{{ numberOfClones }}</td>
            <td>{{ numberOfUniqueClones }}</td>
          </tr>
        </tbody>
      </table>
      <p> {{ chart }} </p>
  </div>
</template>


<script>
export default {
  props: ['source', 'citeUrl', 'citeText', 'title'],
  data() {
    return {
      numberOfClones: "",
      numberOfUniqueClones: ""
    }
  },
  computed: {
    repo() {
      return this.$store.state.gitRepo
    },
    chart() {
      let repo = window.AugurAPI.Repo({ gitURL: this.repo })
      let owner = repo.gitURL.split("/")[1];
      let project = repo.gitURL.split('/')[2];
      let token = "githubAPItoken"; // any way to obtain this? maybe prompt user to enter credentials..?
      // this may not be obtainable with security in mind since the user needs push access to the repo to get clone info
        
        $.ajax({
            url: "https://api.github.com/repos/" + owner + "/" + project + "/traffic/clones",
            type: "GET",
            headers: {"Accept": "application/vnd.github.v3+json", "Authorization": "token " + token},
            success: (result) => {
                this.numberOfClones = result.count;
                this.numberOfUniqueClones = result.uniques;
            },
            error: (error) => {
                if(error.status == 401) {
                    this.numberOfClones = "Unauthorized. User must have push access to the repo.";
                    this.numberOfUniqueClones = "Unauthorized. User must have push access to the repo.";
                }else {
                    this.numberOfClones = "Unable to retrieve data. User must have push access to the repo.";
                    this.numberOfUniqueClones = "Unable to retrieve data. User must have push access to the repo.";
                }
            }
        });
    }
  }
}

</script>
