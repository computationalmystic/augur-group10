import Vue from 'vue'
import Router from 'vue-router'
import AugurCards from '../components/AugurCards.vue'
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
import DownloadedReposCard from '../components/DownloadedReposCard'
import LoginForm from '../components/LoginForm'
import ControlsTabs from './ControlsTabs.vue'

let routes = [
      {path: '/', component: AugurCards},
      {path: '/login', component: LoginForm},
      {path: '/metrics_status', component: MetricsStatusCard},
      
      {path: '/single/:owner?/:repo', component: ControlsTabs, name: 'single', props: true, canReuse: false, 
        children: [
          {
            path: "gmd",
            name: "gmd",
            component: GrowthMaturityDeclineCard
          },
          {
            path: "diversityinclusion",
            name: "diversityinclusion",
            component: DiversityInclusionCard
          },
          {
            path: "risk",
            name: "risk",
            component: RiskCard
          },
          {
            path: "/value",
            name: "value",
            component: ValueCard
          },
          {
            path: "/experiemental",
            name: "experiemental",
            component: ExperimentalCard
          },
        ]
      },
      {path: '/singlegit/:repo', component: ControlsTabs, name: 'singlegit', props: true, canReuse: false,
        children: [
          {
            path: "/gmd",
            name: "gmd",
            component: GrowthMaturityDeclineCard
          },
          {
            path: "/diversityinclusion",
            name: "diversityinclusion",
            component: DiversityInclusionCard
          },
          {
            path: "/risk",
            name: "risk",
            component: RiskCard
          },
          {
            path: "/value",
            name: "value",
            component: ValueCard
          },
          {
            path: "/experiemental",
            name: "experiemental",
            component: ExperimentalCard
          },
          {
            path: "/git",
            name: "git",
            component: GitCard
          },
          {
            path: "/overview",
            name: "overview",
            component: OverviewCard
          },
        ]
      },
      // {path: '/:tab/:domain/:owner/:repo/comparedto/:comparedowner/:comparedrepo', component: AugurCards, name: 'gitsinglecompare'},
      {path: '/compare/:owner?/:repo/:domain?/comparedto/:comparedowner/:comparedrepo/:compareddomain?', component: ControlsTabs, name: 'singlecompare', props: true, canReuse: false,
        children: [
          {
            path: "/gmd",
            name: "gmd",
            component: GrowthMaturityDeclineCard
          },
          {
            path: "/diversityinclusion",
            name: "diversityinclusion",
            component: DiversityInclusionCard
          },
          {
            path: "/risk",
            name: "risk",
            component: RiskCard
          },
          {
            path: "/value",
            name: "value",
            component: ValueCard
          },
          {
            path: "/experiemental",
            name: "experiemental",
            component: ExperimentalCard
          },
          {
            path: "/git",
            name: "git",
            component: GitCard
          },
        ]
      },
      {path: '/groupcompare/:groupid', component: ControlsTabs, name: 'group', props: true, canReuse: false,
        children: [
          {
            path: "/gmd",
            name: "gmd",
            component: GrowthMaturityDeclineCard
          },
          {
            path: "/diversityinclusion",
            name: "diversityinclusion",
            component: DiversityInclusionCard
          },
          {
            path: "/risk",
            name: "risk",
            component: RiskCard
          },
          {
            path: "/value",
            name: "value",
            component: ValueCard
          },
          {
            path: "/experiemental",
            name: "experiemental",
            component: ExperimentalCard
          },
          {
            path: "/git",
            name: "git",
            component: GitCard
          },
          {
            path: "/overview",
            name: "overview",
            component: OverviewCard
          },
        ]
      },
]
let downloadedRepos = [], repos = [], projects = []
window.AugurAPI.getDownloadedGitRepos().then((data) => {

  repos = window._.groupBy(data, 'project_name')
  projects = Object.keys(repos)

})
// const routes = routerOptions.map(route => {
//   // let route1 = Object.assign({}, route);
//   return {
//     route,
//     component: () => require(`@/components/${route.component}.vue`)
//   }
// })


export default new Router({
  // routes,
  routes,
  mode: 'history',
  hashbang: false
})