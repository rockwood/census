defprotocol Census.Adapter do
  def fetch(client, params)
end
