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
    if (localStorage.getItem("lRun") != "Scanning") {
        localStorage.setItem("lRun", "Stopped");
        console.log(localStorage.getItem("lRun"));
    }
        var request = new XMLHttpRequest();
        console.log("Refreshed Page");
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
        console.log("LICENSE INFO");
        console.log(localStorage.getItem("lRun"));
        if (localStorage.getItem("lRun") != "Scanning") {
            localStorage.setItem("lRun", "Scanning");
            window.AugurAPI.getLicenseInfo().then(function(data) {
                populate = document.getElementById("populate");
                populate.parentNode.removeChild(populate);
                //Retrieve raw data
                //document.getElementById("licenseInfo").innerHTML = JSON.stringify(data);
                var column = [];
                column.push("Tag");
                column.push("Info");
                tableID = document.getElementById("licenseTable");
                //Add border
                //tableID.setAttribute("border", "2");
                var tr = tableID.insertRow(0);
                for (var i = 0; i < 2; i++)
                {
                    var th = document.createElement("th");
                    th.innerHTML = column[i];
                    tr.appendChild(th);
                }
                console.log(data);
                var g = 0;
                var m = 0;
                for (var k in data[0]) {
                    //console.log(data[0][k]);
                    if (k)
                    {
                        tr = tableID.insertRow(g+1);
                        for (var j = 0; j < 2; j++) {
                        var tab = tr.insertCell(j-1);
                        var info = data[0][k];
                            if (m % 2 == 0)
                            {
                                tab.style.backgroundColor =  "#EAEAEA";
                            }
                            if (j % 2 != 0) {
                                tab.innerHTML = k;
                            }
                            else {
                                if (info == "NOASSERTION" || !info)
                                {
                                    info = "None provided";
                                }
                                tab.innerHTML = info;
                            }
                    }
                    m++;
                    g++;
                    }
                }
            tableLI = document.getElementById("licenseTableLI");
            //Add border
            //tableLI.setAttribute("border", "2");
            var tr = tableLI.insertRow(0);
            var th = document.createElement("th");
            th.innerHTML = "Licenses identified";
            tr.appendChild(th);
            g = 0;
            m = 0;
            for (var n in data[1])
            {
                //console.log(data[1][n]);
                tr = tableLI.insertRow(g+1);
                var tabTwo = tr.insertCell(-1);
                tabTwo.innerHTML = data[1][n];
                if (m % 2 == 0)
                {
                    tabTwo.style.backgroundColor =  "#EAEAEA";
                }
                m++;
                g++;
            }
            console.log("Scanned. Stopping now...");
            localStorage.setItem("lRun", "Stopped");
        })
        .then( () => { 
        }, error => {
            console.log("Error encountered. Stopping now...");
            localStorage.setItem("lRun", "Stopped");
            document.getElementById("populate").innerHTML = "Error occurred when processing license information.";
        });
        }
        loader();
        request.send();
    </script>
    <h2 class="col" style="margin-bottom:20px">CII Best Practices</h2>
    <div class="row" style="text-align:center;width:100%">
        <img class="col" width="200px" height="200px"
        src="https://i.ibb.co/n8f7NjX/CIITPARENT.png" 
        href="https://bestpractices.coreinfrastructure.org/en" 
        style="width:419px;height:146px;margin-left: auto;margin-right: auto;">
        <br>
        <div id="CIIbp" style="margin-left: auto;margin-right: auto;margin-top:20px;" class="col-6">
            <div size="total">
            <img id="CIIbadge" style="height:50px">
            <br>
            <h2 id="CII"></h2>
            </div>
        </div>
        <!--<div id="CIIbp" class="col-6">
            <div size="total">
            <img id="CIIbadge2">
            <p id="CII2"></p>
            </div>
        </div>-->
    </div>
    <div class="row">
        <p id="populate">{{ $store.state.licenseRunning }}</p>
        <p id="licenseInfo"></p>
        <table id="licenseTable">
            <tbody></tbody>
        </table>
        <table id="licenseTableLI">
            <tbody></tbody>
        </table>
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