within Buildings.BoundaryConditions.WeatherData.Examples;
model ReaderTMY3 "Test model for read requested weather data"
  import Buildings;
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam="Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  annotation (Diagram(graphics), __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/BoundaryConditions/WeatherData/Examples/ReaderTMY3.mos"
        "Simulate and plot"));
end ReaderTMY3;