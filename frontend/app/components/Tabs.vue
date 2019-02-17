<template>
  <nav class="tabs">
        <ul>
          <li :class="{ active: (currentTab == 'gmd') }"><a href="#" @click="changeTab" data-value="gmd">Growth, Maturity, and Decline</a></li>
          <li :class="{ active: (currentTab == 'diversityInclusion') }"><a href="#" @click="changeTab" data-value="diversityInclusion">Diversity and Inclusion</a></li>
          <li :class="{ active: (currentTab == 'risk') }"><a href="#" @click="changeTab" data-value="risk">Risk</a></li>
          <li :class="{ active: (currentTab == 'value') }"><a href="#" @click="changeTab" data-value="value">Value</a></li>
          <li :class="{ active: (currentTab == 'activity') }"><a href="#" @click="changeTab" data-value="activity">Activity</a></li>
          <li :class="{ active: (currentTab == 'experimental') }"><a href="#" @click="changeTab" data-value="experimental">Experimental</a></li>  
          <li :class="{ active: (currentTab == 'git'), hidden: !gitRepo }"><a href="#" @click="changeTab" data-value="git">Git</a></li>
          <li :class="{ active: (currentTab == 'overview'), hidden: !gitRepo }"><a href="#" @click="changeTab" data-value="overview">Overview</a></li>
          <!-- <li :class="{ active: (currentTab == 'git'), hidden: !gitRepo }"><a href="#" @click="changeTab" data-value="git">Git</a></li> -->
        </ul>
      </nav>
</template>

<script>

module.exports = {
  computed: {
    gitRepo () {
      return this.$store.state.gitRepo
    }
  },
  methods: {
    changeTab (e) {
      // this.$store.commit('setTab', {
      //   tab: e.target.dataset['value']
      // })
      
      let repo = this.repo

      if(this.$store.state.comparedRepos.length == 1){
          this.$router.push({
          name: 'singlecompare',
          params: {tab: e.target.dataset['value'], owner: this.owner, repo: this.repo, comparedowner: this.comparedowner, comparedrepo: this.comparedrepo}
        })        
      } else if (this.$store.state.comparedRepos.length > 1) {
        this.$router.push({
          name: 'group',
          params: {tab: e.target.dataset['value'], groupid: this.groupid}
        })
      } else if (this.$router.history.current.name == "singlegit") {
        this.$router.push({
          name: 'singlegit',
          params: {tab: e.target.dataset['value'], repo: this.repo}
        })
      } else {
        this.$router.push({
          name: 'single',
          params: {tab: e.target.dataset['value'], owner: this.owner, repo: this.repo}
        })
      }
      
    },
  }
};

</script>