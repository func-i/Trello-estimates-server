## Place all the behaviors and hooks related to the matching controller here.
## All this logic will automatically be available in application.js.
## You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#loadTimeTrackEstimateGraph = ()->
#  $estimationManagementTime = $('#estimation_time_track_time')
#  userEstimations = $estimationManagementTime.data("user-estimations")
#  userTimeTracked = $estimationManagementTime.data("user-time-tracked")
#  differenceEstimationTimeTrack = []
#  for estimation in userEstimations
#
#  userEstimationData =  userEstimations.map (elem)->
#    {
#    dataLabels:
#      enabled: true
#      inside: true
#      format: "Card: #{elem.card_id}"
#    x: new Date(elem.date).getTime()
#    y: elem.estimation
#    }
#
#  userTimeTrackedData =  userTimeTracked.map (elem)->
#    {
#    dataLabels:
#      enabled: true
#      inside: true
#      format: "Card: #{elem.card_id}"
#    x: new Date(elem.date).getTime()
#    y: elem.tracked_time
#    }
#  $estimationManagementTime.highcharts
#    title:
#      text: 'Time Track X Estimation'
#    xAxis:
#      tickInterval: 24 * 3600 * 1000
#      title:
#        text: 'Time'
#      type: 'datetime'
#    yAxis:
#      title:
#        text: 'Hours'
#    series: [
#      {
#      name: 'Estimation ',
#      data: userEstimationData,
#      stack: 'estimation'
#      },
#      {
#      name: 'TimeTracked',
#      data: userTimeTrackedData,
#      stack: 'timetracked'
#      }
#    ]
#
#estimation_management_time = ()->
#  $estimationManagementTime = $('#estimation_management_time')
#  userEstimations = $estimationManagementTime.data("user-estimations")
#  userTimeTracked = $estimationManagementTime.data("manager-estimations")
#
#  userEstimationData =  userEstimations.map (elem)->
#    {
#    dataLabels:
#      enabled: true
#      inside: true
#      format: "Card: #{elem.card_id}"
#    x: new Date(elem.date).getTime()
#    y: elem.estimation
#    }
#
#  userTimeTrackedData =  userTimeTracked.map (elem)->
#    {
#    dataLabels:
#      enabled: true
#      inside: true
#      format: "Card: #{elem.card_id}"
#    x: new Date(elem.date).getTime()
#    y: elem.tracked_time
#    }
#  $estimationManagementTime.highcharts
#    chart:
#      type: 'column'
#    title:
#      text: 'Developer X Manager'
#    xAxis:
#      tickInterval: 24 * 3600 * 1000
#      title:
#        text: 'Time'
#      type: 'datetime'
#    yAxis:
#      title:
#        text: 'Hours'
#    plotOptions:
#      column:
#        borderWidth: 0
#        colorByPoint: true
#        pointWidth: 60
#        groupPadding: 0.3,
#        stacking: 'normal'
#    series: [
#      {
#      name: 'Estimation ',
#      data: userEstimationData,
#      stack: 'estimation'
#      },
#      {
#      name: 'TimeTracked',
#      data: userTimeTrackedData,
#      stack: 'timetracked'
#      }
#    ]
#
#loadTimeTrackEstimateGraph()
#estimation_management_time()