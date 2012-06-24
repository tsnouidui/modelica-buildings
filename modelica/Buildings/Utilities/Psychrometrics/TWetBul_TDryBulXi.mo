within Buildings.Utilities.Psychrometrics;
block TWetBul_TDryBulXi "Model to compute the wet bulb temperature"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  replaceable package Medium =
    Modelica.Media.Interfaces.PartialCondensingGases "Medium model"
                                                            annotation (
      choicesAllMatching = true);

  Modelica.Blocks.Interfaces.RealInput TDryBul(
    start=303,
    final quantity="Temperature",
    final unit="K",
    min=0) "Dry bulb temperature"
    annotation (Placement(transformation(extent={{-120,70},{-100,90}},rotation=
            0)));
  Modelica.Blocks.Interfaces.RealInput p(  final quantity="Pressure",
                                           final unit="Pa",
                                           min = 0) "Pressure"
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}},
                                                                       rotation=
           0)));
  Modelica.Blocks.Interfaces.RealOutput TWetBul(
    start=293,
    final quantity="Temperature",
    final unit="K",
    min=0) "Wet bulb temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}},rotation=0)));
  Modelica.Blocks.Interfaces.RealInput Xi[Medium.nXi]
    "Species concentration at dry bulb temperature"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}},
          rotation=0)));
protected
  Medium.BaseProperties dryBul "Medium state at dry bulb temperature";
  Medium.BaseProperties wetBul(Xi(nominal=0.01*ones(Medium.nXi)))
    "Medium state at wet bulb temperature";
 parameter Real s[Medium.nX](fixed=false)
    "Vector with zero everywhere except where water is";
initial algorithm

    for i in 1:Medium.nX loop
      if Modelica.Utilities.Strings.isEqual(string1=Medium.substanceNames[i],
                                            string2="Water", caseSensitive=false) then
        s[i] :=1;
      else
        s[i] :=0;
      end if;
    end for;
  assert(abs(1-sum(s)) < 1E-5, "Did not find medium species 'water' in the medium model. Change medium model.");
equation
  dryBul.p = p;
  dryBul.T = TDryBul;
  dryBul.Xi = Xi;
  wetBul.phi = 1;
  wetBul.p = dryBul.p;
  wetBul.h = dryBul.h + s * (wetBul.X - dryBul.X)
         * Medium.enthalpyOfLiquid(dryBul.T);
  TWetBul = wetBul.T;
annotation (
  Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}),
          graphics),
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics={
        Ellipse(
          extent={{-22,-94},{18,-56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-14,44},{10,-64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-14,44},{-14,84},{-12,90},{-8,92},{-2,94},{4,92},{8,90},{10,
              84},{10,44},{-14,44}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-14,44},{-14,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,44},{10,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-42,-16},{-14,-16}}, color={0,0,0}),
        Line(points={{-42,24},{-14,24}}, color={0,0,0}),
        Line(points={{-42,64},{-14,64}}, color={0,0,0}),
        Text(
          extent={{-92,100},{-62,56}},
          lineColor={0,0,127},
          textString="TDryBul"),
        Text(
          extent={{-90,8},{-72,-10}},
          lineColor={0,0,127},
          textString="Xi"),
        Text(
          extent={{-90,-72},{-72,-90}},
          lineColor={0,0,127},
          textString="p"),
        Text(
          extent={{62,22},{92,-22}},
          lineColor={0,0,127},
          textString="TWetBul")}),
    defaultComponentName="wetBul",
    Documentation(info="<html>
<p>
Given a moist are medium model, this component computes the states 
of the medium at its wet bulb temperature.
</p><p>
For a use of this model, see for example
<a href=\"modelica://Buildings.Fluid.Sensors.WetBulbTemperature\">Buildings.Fluid.Sensors.WetBulbTemperature</a>
</p>
</html>
",
revisions="<html>
<ul>
<li>
February 22, 2011 by Michael Wetter:<br>
Changed the code sections that obtain the water concentration. The old version accessed
the water concentration using the index of the vector <code>X</code>.
However, Dymola 7.4 cannot differentiate the function if vector elements are accessed
using their index. In the new implementation, an inner product is used to access the vector element.
In addition, the medium substance name is searched using a case insensitive search.
</li>
<li>
February 17, 2010 by Michael Wetter:<br>
Renamed block from <code>WetBulbTemperature</code> to <code>TWetBul_TDryBulXi</code>
and changed obsolete real connectors to input and output connectors.
</li>
<li>
May 19, 2008 by Michael Wetter:<br>
Added relative humidity as a port.
</li>
<li>
May 7, 2008 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"));
end TWetBul_TDryBulXi;