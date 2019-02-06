\\<template>

  <section>
    <h1>Risk</h1>
    <div style="display: inline-block;">
      <h2 id="base" style="display: inline-block; color: black !important">{{ $store.state.baseRepo }}</h2>
      <h2 style="display: inline-block;" class="repolisting" v-if="$store.state.comparedRepos.length > 0"> compared to: 
</h2>
      <h2 style="display: inline-block;" v-for="(repo, index) in $store.state.comparedRepos">
        <span id="compared" v-bind:style="{ 'color': colors[index] }" class="repolisting"> {{ repo }} </span>
      </h2>
    </div>
    <script type="application/javascript">
        var request = new XMLHttpRequest();
        function loader() {
            const basestr = document.getElementById("base").innerHTML;
            const augURL = 'https://github.com/' + basestr;
            request.open('GET', 'https://bestpractices.coreinfrastructure.org/projects.json?pq=' + augURL, true);
            request.onload = function () {
                var data = JSON.parse(this.response)[0];
                if (data != undefined) {
                    //console.log('CII NAME: ' + data.name);
                    //console.log(data);
                    var badgeURL = 'https://bestpractices.coreinfrastructure.org/projects/' + data.id + '/badge';
                    //console.log(badgeURL);
                    document.getElementById("CIIbadge").src = badgeURL;
                    if (data.badge_percentage_0 < 100) {
                        document.getElementById("CII").innerHTML = data.name + ' is currently not passing CII Best Practices.';
                    }
                    else if (data.badge_percentage_1 < 100) {
                        document.getElementById("CII").innerHTML = data.name + ' is currently passing CII Best Practices.';
                    }
                    else if (data.badge_percentage_2 < 100) {
                        document.getElementById("CII").innerHTML = data.name + ' is currently passing CII Best Practices. This project has a siver status.';
                    }
                    else if (data.badge_percentage_2 == 100) {
                        document.getElementById("CII").innerHTML = data.name + ' is currently passing CII Best Practices. <br>' + data.name + ' maintains a gold status.';
                    }
                } else {
                    document.getElementById("CII").innerHTML = 'No best practice data for this repository.';
                }
            };
        }
            /*
            const splitbase = basestr.split("/");
            const owner = splitbase[0];
            const repo = splitbase[1];
            console.log(owner + ' ' + repo);
            var apistring = 'https://localhost:5555/api/unstable/' + owner + '/' + repo + '/dosocsv2/retrieve_license_information/';
            var apisec = 'https://localhost:5555/api/' + owner + '/' + repo + 'timeseries/issue_comments';
            var apithird = 'https://localhost:5555/api/unstable';
            */
        console.log("LICENSE INFO");
        window.AugurAPI.getLicenseInfo().then((data) => {
            document.getElementById("licenseInfo").innerHTML = JSON.stringify(data);
        })
        loader();
        request.send();
    </script>
    <h2 class="col" style="margin-bottom:20px">CII Best Practices</h2>
    <img class="col" width="200px" height="200px" src="https://www.r-consortium.org/wp-content/uploads/sites/13/2018/06/cii_badge-300x300.png" href="https://bestpractices.coreinfrastructure.org/en">
    <div class="row">
        <div id="CIIbp" class="col-6">
            <div size="total">
            <img id="CIIbadge">
            <p id="CII"></p>
            </div>
        </div>
        <div id="CIIbp" class="col-6">
            <div size="total">
            <img id="CIIbadge2">
            <p id="CII"></p>
            </div>
        </div>
    </div>
    <div class="row">
        <p id="licenseInfo"></p>
    </div>
  </section> 
</template> 
<script>
//import RiskChart from './charts/RiskChart'
module.exports = {
  data() {
    return {
      colors: ["#FF3647", "#4736FF","#3cb44b","#ffe119","#f58231","#911eb4","#42d4f4","#f032e6"]
    }
  },
  components: {
    //RiskChart
  }
}
</script>