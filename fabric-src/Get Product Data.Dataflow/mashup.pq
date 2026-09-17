[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared products = let
  Origine = Csv.Document(Web.Contents("https://raw.githubusercontent.com/MicrosoftLearning/dp-data/refs/heads/main/products.csv"), [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Intestazioni alzate di livello" = Table.PromoteHeaders(Origine, [PromoteAllScalars = true]),
  #"Tipo di colonna modificato" = Table.TransformColumnTypes(#"Intestazioni alzate di livello", {{"ProductID", Int64.Type}, {"ProductName", type text}, {"Category", type text}, {"ListPrice", Int64.Type}}, "it")
in
  #"Tipo di colonna modificato";
