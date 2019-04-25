<template>
  <div ref="holder">
      <h3>Lines of code : Number of commits Ratio</h3>
      <table class="commit-lines-per-commit-ratio-table">
        <thead>
          <tr>
            <th>Time Period</th>
            <th>Additions</th>
            <th>Deletions</th>
            <th>Net</th>
            <th>Total</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Past Week</td>
            <td v-if="numberOfCommits.week != 0">{{ (linesChanged.week.additions / numberOfCommits.week).toFixed(3) }}</td>
            <td v-else>{{ 0 }}</td>
            <td v-if="numberOfCommits.week != 0">{{ (linesChanged.week.deletions / numberOfCommits.week).toFixed(3) }}</td>
            <td v-else>{{ 0 }}</td>
            <td v-if="numberOfCommits.week != 0">{{ ((linesChanged.week.additions - linesChanged.week.deletions) / numberOfCommits.week).toFixed(3) }}</td>
            <td v-else>{{ 0 }}</td>
            <td v-if="numberOfCommits.week != 0">{{ ((linesChanged.week.additions + linesChanged.week.deletions) / numberOfCommits.week).toFixed(3) }}</td>
            <td v-else>{{ 0 }}</td>
          </tr>
          <tr>
            <td>Past Month</td>
            <td v-if="numberOfCommits.month != 0">{{ (linesChanged.month.additions / numberOfCommits.month).toFixed(3) }}</td>
            <td v-else>0</td>
            <td v-if="numberOfCommits.month != 0">{{ (linesChanged.month.deletions / numberOfCommits.month).toFixed(3) }}</td>
            <td v-else>0</td>
            <td v-if="numberOfCommits.month != 0">{{ ((linesChanged.month.additions - linesChanged.month.deletions) / numberOfCommits.month).toFixed(3) }}</td>
            <td v-else>0</td>
            <td v-if="numberOfCommits.month != 0">{{ ((linesChanged.month.additions + linesChanged.month.deletions) / numberOfCommits.month).toFixed(3) }}</td>
            <td v-else>0</td>
          </tr>
          <tr>
            <td>Past Year</td>
            <td v-if="numberOfCommits.year != 0">{{ (linesChanged.year.additions / numberOfCommits.year).toFixed(3) }}</td>
            <td v-else>0</td>
            <td v-if="numberOfCommits.year != 0">{{ (linesChanged.year.deletions / numberOfCommits.year).toFixed(3) }}</td>
            <td v-else>0</td>
            <td v-if="numberOfCommits.year != 0">{{ ((linesChanged.year.additions - linesChanged.year.deletions) / numberOfCommits.year).toFixed(3) }}</td>
            <td v-else>0</td>
            <td v-if="numberOfCommits.year != 0">{{ ((linesChanged.year.additions + linesChanged.year.deletions) / numberOfCommits.year).toFixed(3) }}</td>
            <td v-else>0</td>
          </tr>
        </tbody>
      </table>
      <br>
      <p> {{ chart }} </p>
  </div>
</template>


<script>
export default {
  props: ['source', 'citeUrl', 'citeText', 'title'],
  data() {
    let yearBeginDate = new Date();
    yearBeginDate.setFullYear(yearBeginDate.getFullYear() - 1);

    let monthBeginDate = new Date();
    monthBeginDate.setMonth(monthBeginDate.getMonth() - 1);

    let weekBeginDate = new Date();
    weekBeginDate.setDate(weekBeginDate.getDate() - 7);

    return {
      linesChanged: {
          "year": {
              "additions": 0,
              "deletions": 0
          },
          "month": {
              "additions": 0,
              "deletions": 0
          },
          "week": {
              "additions": 0,
              "deletions": 0
          }
      },
      numberOfCommits: {
          "year": 0,
          "month": 0,
          "week": 0
      },
      yearBeginDate: yearBeginDate,
      monthBeginDate: monthBeginDate,
      weekBeginDate: weekBeginDate
    }
  },
  computed: {
    repo() {
      return this.$store.state.gitRepo
    },
    chart() {
      let repo = window.AugurAPI.Repo({ gitURL: this.repo })

      repo.changesByAuthor().then((changes) => {
        changes.forEach((change) => {
            let changeDate = (new Date(change.author_date));
            
            if(changeDate.getTime() >= this.yearBeginDate.getTime() && changeDate.getTime() <= (new Date()).getTime()) {
              this.linesChanged.year.additions += (change.additions || 0);
              this.linesChanged.year.deletions += (change.deletions || 0);
            }

            if(changeDate.getTime() >= this.monthBeginDate.getTime() && changeDate.getTime() <= (new Date()).getTime()) {
              this.linesChanged.month.additions += (change.additions || 0);
              this.linesChanged.month.deletions += (change.deletions || 0);
            }

            if(changeDate.getTime() >= this.weekBeginDate.getTime() && changeDate.getTime() <= (new Date()).getTime()) {
              this.linesChanged.week.additions += (change.additions || 0);
              this.linesChanged.week.deletions += (change.deletions || 0);
            }
        })
      })

      repo.codeCommits().then((commits) => {
        commits.forEach((commit) => {
          let commitDate = (new Date(commit.date));

          if(commitDate.getTime() >= this.yearBeginDate.getTime() && commitDate.getTime() <= (new Date()).getTime()) {
            this.numberOfCommits.year += commit.commits;
          }

          if(commitDate.getTime() >= this.monthBeginDate.getTime() && commitDate.getTime() <= (new Date()).getTime()) {
            this.numberOfCommits.month += commit.commits;
          }

          if(commitDate.getTime() >= this.weekBeginDate.getTime() && commitDate.getTime() <= (new Date()).getTime()) {
            this.numberOfCommits.week += commit.commits;
          }
        });
      });
    }
  },
  // methods & mounted are for figuring out what is returned
  methods: {
    getDBInfo: function() {
      var repo = window.AugurAPI.Repo({ gitURL: this.repo });

      repo.codeCommits().then((commits) => {
        // inspect what codeCommits() returns
        console.dir(commits);
        // inspect individual commit object
        console.dir(commits[0]);
      });
      repo.changesByAuthor().then((changes) => {
        // inspect what changesByAuthor() returns
        console.dir(changes);
        // inspect individual change object
        console.dir(changes[0]);
      });

      console.dir(this.linesChanged);
      console.dir(this.numberOfCommits);
    }
  },
  mounted: function() {
    this.getDBInfo();
  }
}

</script>

