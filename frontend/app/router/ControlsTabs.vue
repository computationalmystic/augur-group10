<template>
   
  <div>
    <div class="fullwidth">
      <augur-header></augur-header>
    </div>
    <!-- content to show if app has no state yet -->
    <div :class="{ hidden: hasState }">
      <section class="unmaterialized">
        <div id="collapse">
          <h3>Downloaded Git Repos by Project</h3>
        </div>
        <downloaded-repos-card></downloaded-repos-card>
      </section>
    </div>

    <!-- content to show if app does have a repo to show -->
    <div :class="{ hidden: !hasState }">
      <!-- <nav class="tabs">
        <ul>
          <li :class="{ active: (currentTab == 'gmd') }"><a href="#" @click="changeTab" data-value="gmd">Growth, Maturity, and Decline</a></li>
          <li :class="{ active: (currentTab == 'diversityInclusion') }"><a href="#" @click="changeTab" data-value="diversityInclusion">Diversity and Inclusion</a></li>
          <li :class="{ active: (currentTab == 'risk') }"><a href="#" @click="changeTab" data-value="risk">Risk</a></li>
          <li :class="{ active: (currentTab == 'value') }"><a href="#" @click="changeTab" data-value="value">Value</a></li>
          <li :class="{ active: (currentTab == 'activity') }"><a href="#" @click="changeTab" data-value="activity">Activity</a></li>
          <li :class="{ active: (currentTab == 'experimental') }"><a href="#" @click="changeTab" data-value="experimental">Experimental</a></li>
          <li :class="{ active: (currentTab == 'git') }"><router-link :to="{name: 'singlegit', params: {tab: 'git', repo: e.url}}" @click.native="open = false">Git</router-link></li>
        </ul>
      </nav> -->

      <div ref="cards">
        <main-controls></main-controls>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import AugurHeader from '../components/AugurHeader.vue'
import MetricsStatusCard from '../components/MetricsStatusCard.vue'
import BaseRepoActivityCard from '../components/BaseRepoActivityCard.vue'
import BaseRepoEcosystemCard from '../components/BaseRepoEcosystemCard.vue'
import GrowthMaturityDeclineCard from '../components/GrowthMaturityDeclineCard'
import RiskCard from '../components/RiskCard'
import ValueCard from '../components/ValueCard'
import DiversityInclusionCard from '../components/DiversityInclusionCard'
import GitCard from '../components/GitCard'
import OverviewCard from '../components/OverviewCard.vue'
import ExperimentalCard from '../components/ExperimentalCard'
import DownloadedReposCard from '../components/DownloadedReposCard.vue'
import MainControls from '../components/MainControls.vue'
import LoginForm from '../components/LoginForm'
import ControlsTabs from './ControlsTabs.vue'
import { mapState } from 'vuex'

module.exports = {
  props: ['tab', 'owner', 'repo', 'domain', 'comparedowner', 'comparedrepo', 'groupid'],
  components: {
    MainControls,
    AugurHeader,
    MetricsStatusCard,
    BaseRepoActivityCard,
    BaseRepoEcosystemCard,
    GrowthMaturityDeclineCard,
    RiskCard,
    ValueCard,
    DiversityInclusionCard,
    GitCard,
    ExperimentalCard,
    DownloadedReposCard,
    LoginForm
  },
  created(to, from, next) {
    if(this.repo || this.groupid){
      this.$store.commit("resetTab")
      this.$store.commit('setTab', {
        tab: this.tab
      })
      if (this.$router.history.current.name == "singlegit"){
        this.$store.commit('setRepo', {
          gitURL: this.repo
        })
      } else if (!this.groupid){
        if (this.repo.includes('github')) {
          this.$store.commit('setRepo', {
            gitURL: this.repo
          })
        } else {
          this.$store.commit('setRepo', {
            githubURL: this.owner + '/' + this.repo
          })
        }
      }
      if(this.comparedrepo) { 
        this.$store.commit('addComparedRepo', {
          githubURL: this.comparedowner + '/' + this.comparedrepo
        })
      }
      if(this.groupid){
        let repos = this.groupid.split('+')
        if (repos[0].includes('github')) {
          this.$store.commit('setRepo', {
            gitURL: repos[0]
          })
        } else {
          this.$store.commit('setRepo', {
            githubURL: repos[0]
          })
        }
        repos.shift()
        // repos.pop()
        repos.forEach((cmprepo) => {
          this.$store.commit('addComparedRepo', {
            githubURL: cmprepo
          })
        })
      }
    }
  },
  watch: {
    // comparedRepos: function(){
    //   localStorage.setItem('group', JSON.stringify(this.$store.state.comparedRepos));
       
    //   if (this.gitRepo != null){
    //     localStorage.setItem('domain', this.domain)
    //     localStorage.setItem('git', this.$store.state.gitRepo)
    //   }
    //   console.log(localStorage.getItem('git'), "this is it") 
    //   localStorage.setItem('base', this.$store.state.baseRepo)
      
    //   if(this.$store.state.comparedRepos.length > 1){
    //     localStorage.setItem("groupid", this.groupid)
    //     localStorage.setItem('repo', this.repo)
    //     localStorage.setItem('owner', this.owner)
    //   }
    // },
    '$route': function (to, from) {
      console.log(to, from)
      if (to.path != from.path)
        // window.location.reload()
        window.location.replace(to.path)
    }
  },
  currentTab() {
    return this.$store.state.tab
  },
}

