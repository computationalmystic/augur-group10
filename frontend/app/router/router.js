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
import DownloadedReposCard from '../components/DownloadedReposCard.vue'
import LoginForm from '../components/LoginForm'
import ControlsTabs from '../components/ControlsTabs.vue'
import MainControls from '../components/MainControls.vue'
import AugurHeader from '../components/AugurHeader.vue'
import Tabs from '../components/Tabs.vue'



let routes = [
      {path: '/', component: ControlsTabs,
        children: [
          {
            path: "",
            name: "reposcard",
            components: {
              header: AugurHeader,
              content: DownloadedReposCard
            }
          },
        ]
      },
      {path: '/login', component: LoginForm},
      {path: '/metrics_status', 
        components: {
          header: AugurHeader,
          content: MainControls
        }
      },
      
      {path: '/single/:owner?/:repo', name: 'single', props: true, canReuse: false, components: {
        header: AugurHeader,
        tabs: Tabs,
        ControlsTabs: MainControls,
      },
        children: [
          {
            path: "gmd",
            name: "gmd",
            components: {
              content: GrowthMaturityDeclineCard
            }
          },
          {
            path: "diversityinclusion",
            name: "diversityinclusion",
            components: {
              content: DiversityInclusionCard
            }
          },
          {
            path: "risk",
            name: "risk",
            components: {
              content: RiskCard
            }
          },
          {
            path: "/value",
            name: "value",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: ValueCard
            }
          },
          {
            path: "/experiemental",
            name: "experiemental",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: ExperimentalCard
            }
          },
          {
            path: "/git",
            name: "git",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: GitCard
            }
          },
          {
            path: "/overview",
            name: "overview",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: OverviewCard
            }
          },
        ]
      },
      // {path: '/:tab/:domain/:owner/:repo/comparedto/:comparedowner/:comparedrepo', component: AugurCards, name: 'gitsinglecompare'},
      {path: '/compare/:owner?/:repo/:domain?/comparedto/:comparedowner/:comparedrepo/:compareddomain?', component: ControlsTabs, name: 'singlecompare', props: true, canReuse: false,
        children: [
          {
            path: "gmd",
            name: "gmd",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: GrowthMaturityDeclineCard
            }
          },
          {
            path: "diversityinclusion",
            name: "diversityinclusion",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: DiversityInclusionCard
            }
          },
          {
            path: "risk",
            name: "risk",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: RiskCard
            }
          },
          {
            path: "/value",
            name: "value",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: ValueCard
            }
          },
          {
            path: "/experiemental",
            name: "experiemental",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: ExperimentalCard
            }
          },
          {
            path: "/git",
            name: "git",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: GitCard
            }
          },
        ]
      },
      {path: '/groupcompare/:groupid', component: ControlsTabs, name: 'group', props: true, canReuse: false,
        children: [
          {
            path: "gmd",
            name: "gmd",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: GrowthMaturityDeclineCard
            }
          },
          {
            path: "diversityinclusion",
            name: "diversityinclusion",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: DiversityInclusionCard
            }
          },
          {
            path: "risk",
            name: "risk",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: RiskCard
            }
          },
          {
            path: "/value",
            name: "value",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: ValueCard
            }
          },
          {
            path: "/experiemental",
            name: "experiemental",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: ExperimentalCard
            }
          },
          {
            path: "/git",
            name: "git",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: GitCard
            }
          },
          {
            path: "/overview",
            name: "overview",
            components: {
              header: AugurHeader,
              tabs: Tabs,
              controls: MainControls,
              content: OverviewCard
            }
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