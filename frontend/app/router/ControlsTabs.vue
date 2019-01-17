<template>
   
  <div>
    <div class="fullwidth">
      <augur-header></augur-header>
    </div>
    <!-- content to show if app has no state yet -->
    <div :class="{ hidden: hasState }">
      <!-- <login-form></login-form> -->
      <section class="unmaterialized">
        <div id="collapse">
          <h3>Downloaded Git Repos by Project</h3>
          <!--<h3 v-if="isCollapsed" @click="collapseText">Downloaded Git Repos by Project,  <span style="font-size:16px">&#9660</span></h3>
          <h3 v-else @click="collapseText">Downloaded Git Repos by Project  <span style="font-size:16px">&#9654</span></h3>-->
        </div>
        <downloaded-repos-card></downloaded-repos-card>
      </section>
    </div>

    <!-- content to show if app does have a repo to show -->
    <div :class="{ hidden: !hasState }">
      <nav class="tabs">
        <ul>
          <li :class="{ active: (currentTab == 'gmd') }"><a href="#" @click="changeTab" data-value="gmd">Growth, Maturity, and Decline</a></li>
          <li :class="{ active: (currentTab == 'diversityInclusion') }"><a href="#" @click="changeTab" data-value="diversityInclusion">Diversity and Inclusion</a></li>
          <li :class="{ active: (currentTab == 'risk') }"><a href="#" @click="changeTab" data-value="risk">Risk</a></li>
          <li :class="{ active: (currentTab == 'value') }"><a href="#" @click="changeTab" data-value="value">Value</a></li>
          <li :class="{ active: (currentTab == 'activity') }"><a href="#" @click="changeTab" data-value="activity">Activity</a></li>
          <li :class="{ active: (currentTab == 'experimental') }"><a href="#" @click="changeTab" data-value="experimental">Experimental</a></li>
          <li :class="{ active: (currentTab == 'git') }"><router-link :to="{name: 'singlegit', params: {tab: 'git', repo: e.url}}" @click.native="open = false">Git</router-link></li>
        </ul>
      </nav>

      <div ref="cards">
        <main-controls></main-controls>
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>
import MainControls from './MainControls'
import AugurHeader from './AugurHeader'
import MetricsStatusCard from './MetricsStatusCard'
import BaseRepoActivityCard from './BaseRepoActivityCard'
import BaseRepoEcosystemCard from './BaseRepoEcosystemCard'
import GrowthMaturityDeclineCard from './GrowthMaturityDeclineCard'
import RiskCard from './RiskCard'
import ValueCard from './ValueCard'
import DiversityInclusionCard from './DiversityInclusionCard'
import GitCard from './GitCard'
import ExperimentalCard from './ExperimentalCard'
import DownloadedReposCard from './DownloadedReposCard'
import LoginForm from './LoginForm'
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
  currentTab() {
    return this.$store.state.tab
  },
}

