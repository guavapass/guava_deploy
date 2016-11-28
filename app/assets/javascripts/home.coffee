# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  statsChart("#statsAllTime", labelsAllTime, dataAllTime)
  statsChart("#statsLastUsed", labelsLastUsed, dataLastUsed)
  devAtmosphere()

devAtmosphere = ->
  urls = {
    humidity: 'https://us.wio.seeed.io/v1/node/GroveTempHumD0/humidity?access_token=c6cd59b573d5c662f0a58b1294e30645',
    temp: 'https://us.wio.seeed.io/v1/node/GroveTempHumD0/temperature?access_token=c6cd59b573d5c662f0a58b1294e30645'
  }

  $.get(
    url: urls.temp
    success: (data) ->
      $('#dev-temp').html(data.celsius_degree)
  )

  $.get(
    url: urls.humidity
    success: (data) ->
      $('#dev-humidity').html(data.humidity)
  )

statsChart = (chartId, labelSet, dataSet) ->
  ctx = $(chartId)

  myChart = new Chart(ctx,
    type: 'bar'
    data:
      labels: labelSet
      datasets: [ {
        label: 'Visits'
        data: dataSet
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)'
          'rgba(54, 162, 235, 0.2)'
          'rgba(255, 206, 86, 0.2)'
          'rgba(75, 192, 192, 0.2)'
          'rgba(153, 102, 255, 0.2)'
          'rgba(255, 159, 64, 0.2)'
          'rgba(255, 99, 132, 0.2)'
          'rgba(54, 162, 235, 0.2)'
          'rgba(255, 206, 86, 0.2)'
          'rgba(75, 192, 192, 0.2)'
          'rgba(153, 102, 255, 0.2)'
          'rgba(255, 159, 64, 0.2)'
        ]
        borderColor: [
          'rgba(255,99,132,1)'
          'rgba(54, 162, 235, 1)'
          'rgba(255, 206, 86, 1)'
          'rgba(75, 192, 192, 1)'
          'rgba(153, 102, 255, 1)'
          'rgba(255, 159, 64, 1)'
          'rgba(255,99,132,1)'
          'rgba(54, 162, 235, 1)'
          'rgba(255, 206, 86, 1)'
          'rgba(75, 192, 192, 1)'
          'rgba(153, 102, 255, 1)'
          'rgba(255, 159, 64, 1)'
        ]
        borderWidth: 1
      } ]
    options: scales: yAxes: [ { ticks: beginAtZero: true } ])
