defprotocol Census.Adapter do
  def fetch(client, query)
end
