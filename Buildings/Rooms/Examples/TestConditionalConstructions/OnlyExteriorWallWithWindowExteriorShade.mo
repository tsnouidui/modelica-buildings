within Buildings.Rooms.Examples.TestConditionalConstructions;
model OnlyExteriorWallWithWindowExteriorShade "Test model for room model"
  extends Modelica.Icons.Example;
  extends BaseClasses.PartialTestModel(
   nConExt=0,
   nConExtWin=2,
   nConPar=0,
   nConBou=0,
   nSurBou=0,
   roo(
    datConExtWin(layers={matLayExt, matLayExt}, each A=10,
                 glaSys={glaSys, glaSys},
                 each wWin=2, 
                 each hWin=2, 
                 each fFra=0.1,
                 til={Buildings.HeatTransfer.Types.Tilt.Floor, Buildings.HeatTransfer.Types.Tilt.Ceiling},
                 each azi=Buildings.HeatTransfer.Types.Azimuth.W)),
    glaSys(haveExteriorShade=true));
  Modelica.Blocks.Sources.Constant uSha(k=0.5)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=max(1,nConExtWin))
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
equation
  connect(uSha.y,replicator. u) annotation (Line(
      points={{-59,70},{-22,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(roo.uSha,replicator. y) annotation (Line(
      points={{42,2.66454e-15},{20,2.66454e-15},{20,70},{1,70}},
      color={0,0,127},
      smooth=Smooth.None));
   annotation(__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/TestConditionalConstructions/OnlyExteriorWallWithWindowExteriorShade.mos" "Simulate and plot"),
   Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            200,160}})),
    experiment(
      StopTime=86400));
end OnlyExteriorWallWithWindowExteriorShade;
