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
          <tr v-for="contributor in contributors.slice(0, 10)">
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