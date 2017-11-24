class CreateWithoutValidationStrategy
  def initialize
    @strategy = FactoryBot.strategy_by_name(:build).new
  end

  delegate :association, to: :@strategy

  def result(evaluation)
    strategy_result = @strategy.result(evaluation)
    strategy_result.save!(validate: false)
    strategy_result
  end
end
