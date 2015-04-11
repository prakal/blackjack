class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->


  stand: ->
    @at(0).flip()
    @hit()

  hit: ->
    @add(@deck.pop())

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  hasBusted: false

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    score =  @minScore() + 10 * @hasAce()
    if score > 21
      score = @minScore()
    score


