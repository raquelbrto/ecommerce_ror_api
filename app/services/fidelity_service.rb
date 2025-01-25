class FidelityService
  def initialize
    @fidelity_client = FidelityClient.new
  end

  def process_bonus(user_id, amount)
    @fidelity_client.send_bonus(user_id, amount)
    rescue => e
      Rails.logger.error("Error adding points: #{e.message}")
      fallback_process_bonus(user_id, amount)
  end

  private

  def fallback_process_bonus(user_id, amount)
    ProcessBonusWorker.perform_async(user_id, amount)
  end
end
