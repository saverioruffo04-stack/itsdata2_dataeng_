[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "products_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared products = let
  Origine = Csv.Document(Web.Contents("https://raw.githubusercontent.com/MicrosoftLearning/dp-data/refs/heads/main/products.csv"), [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Intestazioni alzate di livello" = Table.PromoteHeaders(Origine, [PromoteAllScalars = true]),
  #"Tipo di colonna modificato" = Table.TransformColumnTypes(#"Intestazioni alzate di livello", {{"ProductID", Int64.Type}, {"ProductName", type text}, {"Category", type text}, {"ListPrice", Int64.Type}}, "it")
in
  #"Tipo di colonna modificato";
shared products_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "8d20343b-56af-4125-b338-3e5e936018e9"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "2e03db71-78ca-4268-8b41-d0962bae5c49"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "products", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
