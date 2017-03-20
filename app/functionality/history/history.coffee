class History
  constructor: ->
    @clear()

  getAllStepsData: (slideId)->
    @getJsonData "./jsons/navigation.json", (map) =>
      @allStepsNavigation = map
    @getJsonData "./jsons/" + slideId + ".json", (data) =>
      @allStepsData = data.steps

  getJsonData: (path, callback)->
    xmlHttpRequest = new XMLHttpRequest
    xmlHttpRequest.open 'GET', path, false
    xmlHttpRequest.onreadystatechange = ->
      if xmlHttpRequest.readyState != 4
        return
      if xmlHttpRequest.status != 0 and xmlHttpRequest.status != 200
        return
      callback JSON.parse( xmlHttpRequest.responseText )
    xmlHttpRequest.send()

  getStepData: (stepId)->
    step = {}
    step.id = stepId
    step.data = @allStepsData[stepId]
    step.next = @allStepsNavigation.map[stepId].next
    step.back = @allStepsNavigation.map[stepId].back
    step

  clear: ->
    @steps = []
    @currentStep = {}

  stepNext: (stepId)->
    step = @getStepData(stepId)
    if step
      @steps.push(step)
      @currentStep = step
      @removeIllegalSteps()
      @setBackButton()
    @currentStep

  stepBack: (stepId)->
    if @isStepInStack(stepId)
      while(@steps.length > 0)
        if @steps.pop().id is stepId then break
      @currentStep = @getLastElement()
    else
      @stepNext(stepId)

  isStepInStack: (stepId)->
    @steps.some (step)->
      step.id is stepId

  setBackButton: ()->
    if @currentStep.back
      @removeStep(@currentStep.back)

  removeStep: (stepId)->
    @steps = @steps.filter (step)->
      stepId isnt step.id

  getLastElement: ()->
    if @steps.length > 0 then @steps[@steps.length - 1] else {}

  isCurrentStep: (step)->
    step.id is @currentStep.id

  getStepNumber: (step)->
    Number(step.replace('step', ''))

  removeIllegalSteps: ()->
    @legalSteps = @steps.filter (step)=>
      @getStepNumber(step.id) <= @getStepNumber(@currentStep.id)
    @steps = @legalSteps

window.History = new History()