# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

loadEstimateManagementGraph = ()->
  $('#estimation_management_time').highcharts
    chart:
      type: 'line'
    title:
      text: 'Fruit Consumption'
    xAxis:
      title:
        text:  'Time'
    yAxis:
      categories: ['Developer', 'Manager']
    series: [
      {
      name: 'Jane',
      data: [1, 0]
      },
      {
      name: 'John',
      data: [5, 7]
      }
    ]

loadEstimateManagementGraph()