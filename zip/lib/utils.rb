SEARCH_ENGINE_IPS = ["66.249.71.134", "66.249.71.166", "66.249.67.3", "216.129.119.10", "77.88.26.25", "94.100.181.100", "81.19.66.89", "66.249.71.236", "66.249.71.201", "66.249.71", "77.88.26"]
SEARCH_ENGINE_NAMES = ['Spider', 'Meta', 'Google', 'Stack', 'Rambler', 'StackRambler', 'Spider' ,'Aport', 'Yahoo', 'MSN', 'Yandex', 'bot', 'MSIE incompatible', 'Bing', 'Crawler']

module StatisticsHelper
  
  def StatisticsHelper.allowed_ip?(request)
    return false if StatisticsHelper.bot?(request)
    ip = request.remote_ip
    SEARCH_ENGINE_IPS.each do |i|
      return false if ip.include?(i)
    end
    true
  end
  
  def StatisticsHelper.bot?(request)
    user_agent = request.env['HTTP_USER_AGENT']
    SEARCH_ENGINE_NAMES.detect{ |bot| bot if user_agent.match(bot)}
  end
  
end