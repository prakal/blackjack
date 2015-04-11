# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  logic: ->
    dealerHand = @get('dealerHand').scores()[0]
    debugger
    if @get('dealerHand').hasAce() and dealerHand <= 16
      console.log ("dealer hits")
      @get('dealerHand').hit()
      @logic
    else
      @isBusted()
      @scoreEval()

  isBusted: ->
    if @get('playerHand').scores()[1] > 21 and !@get('playerHand').hasAce()
      console.log ("Player busts")
      @get('playerHand').hasBusted = true
    else
      if @get('playerHand').scores[0] > 21
        console.log ("Player busts")
        @get('playerHand').hasBusted = true
      else
        if @get('dealerHand').scores()[1] > 21 and !@get('dealerHand').hasAce()
          console.log ("Dealer busts")
          @get('dealerHand').hasBusted = true
        else
          if @get('dealerHand').scores[0] > 21
            console.log("Dealer busts")
            @get('dealerHand').hasBusted = true

  scoreEval: ->
    if @get('playerHand').hasBusted
      console.log ("...Dealer Wins")
    else
      if @get('dealerHand').hasBusted
        console.log ("...Player Wins")
      else
        if @get('playerHand').scores()[0] > @get('dealerHand').scores()[0]
          console.log ("Player wins")
        else
          if @get('playerHand').scores()[0] == @get('dealerHand').scores()[0]
            console.log ("Draw, game over")
          else
            console.log ("Dealer wins")


    # console.log "...Dealer Wins" if @get('playerHand').hasBusted
    # console.log "...Player Wins" if @get('dealerHand').hasBusted

    # if @get('playerHand').scores()[0] > @get('dealerHand').scores()[0]
    #   console.log ("Player wins")
    # else
    #   if @get('playerHand').scores()[0] == @get('dealerHand').scores()[0]
    #     console.log ("Draw, game over")
    #   else
    #     console.log ("Dealer wins")


# The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
