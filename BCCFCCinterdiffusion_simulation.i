[Mesh]
  type = GeneratedMesh
  dim =1
  nx =1000
  xmin = 0
  xmax = 1000
  elem_type =EDGE2
[]


[AuxVariables]
  [./Energy]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Variables]
  # concentration
  [./xCr]
    order = FIRST
    family = LAGRANGE
  [../]

  [./xAl]
    order = FIRST
    family = LAGRANGE
  [../]

  [./xFe]
    order = FIRST
    family = LAGRANGE
  [../]


  # order parameter 1
  [./eta1]
    order = FIRST
    family = LAGRANGE
  [../]

  # order parameter 2
  [./eta2]
    order = FIRST
    family = LAGRANGE
  [../]

  # phase concentration 11
  [./xCr_FCC]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.182
  [../]

  # phase concentration 13
  [./xCr_BCC]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.84553
  [../]

  # phase concentration 21
  [./xAl_FCC]
    order = FIRST
    family = LAGRANGE
    initial_condition =0.04705
  [../]

  # phase concentration 23
  [./xAl_BCC]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.00036
  [../]

  # phase concentration 31
  [./xFe_FCC]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0.35763
  [../]

  # phase concentration 33
  [./xFe_BCC]
    order = FIRST
    family = LAGRANGE
    initial_condition =0.14601
  [../]

  #diffusion potential
  [./w1]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0
  [../]

  [./w2]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0
  [../]

  [./w3]
    order = FIRST
    family = LAGRANGE
    initial_condition = 0
  [../]
[]

[ICs]
  [./eta1]
  variable = eta1
  type = FunctionIC
  function = '1*if((x>=0&x<800),1,0)'
  [../]

  [./eta2]
    variable = eta2
    type = FunctionIC
    function = '1*if((x>=800&x<=1000),1,0)'
  [../]


  [./xCr]
    variable = xCr
    type = FunctionIC
    function = '0.1413*if((x>=0&x<800&y>=0&y<=200),1,0)+0.84553*if((x>=800&x<=1000&y>=0&y<=200),1,0)'
  [../]

  [./xAl]
    variable = xAl
    type = FunctionIC
   function = '0.04991*if((x>=0&x<800&y>=0&y<=200),1,0)+0.00036*if((x>=800&x<=1000&y>=0&y<=200),1,0)'
  [../]

  [./xFe]
    variable = xFe
    type = FunctionIC
    function = ' 0.37061*if((x>=0&x<800&y>=0&y<=200),1,0)+0.14601*if((x>=800&x<=1000&y>=0&y<=200),1,0)'
  [../]
[]


[Materials]
  [./FFCC]
    type = DerivativeParsedMaterial
    f_name = FFCC
    args = 'xCr_FCC xAl_FCC xFe_FCC'
function = '(1.236e-4)*(-14407.52769*xFe_FCC+35328.21285*xFe_FCC^2-22046.01708*xFe_FCC^3-143086.2648*xAl_FCC+52083.04793*xAl_FCC*xFe_FCC+54078.43718*xAl_FCC*xFe_FCC^2-
41385.59159*xAl_FCC*xFe_FCC^3+40024.33541*xAl_FCC^2+392913.0659*xAl_FCC^2*xFe_FCC-260363.4907*xAl_FCC^2*xFe_FCC^2+334225.2193*xAl_FCC^3-454930.1113*xAl_FCC^3*xFe_FCC-7255.075048*xCr_FCC+
79926.38618*xCr_FCC*xFe_FCC-62774.97837*xCr_FCC*xFe_FCC^2+10622.13197*xCr_FCC*xFe_FCC^3+125044.7974*xCr_FCC*xAl_FCC+110612.8659*xCr_FCC*xAl_FCC*xFe_FCC-132552.8574*xCr_FCC*xAl_FCC*xFe_FCC^2+328423.8569*xCr_FCC*xAl_FCC^2-
529786.4451*xCr_FCC*xAl_FCC^2*xFe_FCC-464845.2355*xCr_FCC*xAl_FCC^3+56074.35143*xCr_FCC^2-75226.24646*xCr_FCC^2*xFe_FCC+12284.3462*xCr_FCC^2*xFe_FCC^2+27960.95731*xCr_FCC^2*xAl_FCC-
142848.5462*xCr_FCC^2*xAl_FCC*xFe_FCC-285145.7991*xCr_FCC^2*xAl_FCC^2-27604.25028*xCr_FCC^3+3397.150902*xCr_FCC^3*xFe_FCC-69437.08732*xCr_FCC^3*xAl_FCC-42889.16286*1-9542.069461*xCr_FCC^4-
249271.2109*xAl_FCC^4+3999.560357*xFe_FCC^4+8.314*973*(xCr_FCC*log(xCr_FCC)+xAl_FCC*log(xAl_FCC)+xFe_FCC*log(xFe_FCC)+(1-xCr_FCC-xAl_FCC-xFe_FCC)*log(1-xCr_FCC-xAl_FCC-xFe_FCC)))'
  [../]

  [./FBCC]
    type = DerivativeParsedMaterial
    f_name = FBCC
    args = 'xCr_BCC xAl_BCC xFe_BCC'
function = '(1.236e-4)*(-12606.55684*xFe_BCC+7903.40843338*xFe_BCC^2-87.4364145772*xFe_BCC^3-157777.582652*xAl_BCC+190346.725861*xAl_BCC*xFe_BCC-197020.357491*xAl_BCC*xFe_BCC^2+91102.5610235*xAl_BCC*xFe_BCC^3+153656.74291*xAl_BCC^2-
303483.398283*xAl_BCC^2*xFe_BCC+318166.24139*xAl_BCC^2*xFe_BCC^2-1574242.38083*xAl_BCC^3+7161.66628817*xAl_BCC^3*xFe_BCC-22756.7778846*xCr_BCC+85755.4154135*xCr_BCC*xFe_BCC-36463.4830684*xCr_BCC*xFe_BCC^2+460.653362414*xCr_BCC*xFe_BCC^3+
191569.954482*xCr_BCC*xAl_BCC-347135.473714*xCr_BCC*xAl_BCC*xFe_BCC+220036.374974*xCr_BCC*xAl_BCC*xFe_BCC^2-47411.3719905*xCr_BCC*xAl_BCC^2+330551.005905*xCr_BCC*xAl_BCC^2*xFe_BCC+1792198.08379*xCr_BCC*xAl_BCC^3+83666.6304535*xCr_BCC^2-110124.355948*xCr_BCC^2*xFe_BCC+
8873.70030796*xCr_BCC^2*xFe_BCC^2-108606.361277*xCr_BCC^2*xAl_BCC+149475.765087*xCr_BCC^2*xAl_BCC*xFe_BCC-1448.01126014*xCr_BCC^2*xAl_BCC^2-66840.1278622*xCr_BCC^3+17871.620101*xCr_BCC^3*xFe_BCC+4219.45000395*xCr_BCC^3*xAl_BCC-36823.3759071*1+
7572.74979351*xCr_BCC^4+39426439.8318*xAl_BCC^4-421.441770124*xFe_BCC^4+8.314*973*(xCr_BCC*log(xCr_BCC)+xAl_BCC*log(xAl_BCC)+xFe_BCC*log(xFe_BCC)+(1-xCr_BCC-xAl_BCC-xFe_BCC)*log(1-xCr_BCC-xAl_BCC-xFe_BCC)))'
   [../]

  # Switching functions for each phase
  # h1(eta1, eta2)
  [./h1]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = h1
    all_etas = 'eta1 eta2'
    phase_etas = 'eta1'
  [../]
  # h2(eta1, eta2)
  [./h2]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = h2
    all_etas = 'eta1 eta2'
    phase_etas = 'eta2'
  [../]

  # constant properties
[./constants]
     type = GenericConstantMaterial
     prop_names  = 'L   mu kappa gamma12'
     prop_values = '0.0134   1   3   1.5'
[../]

     [./M11]
    type = DerivativeParsedMaterial
    material_property_names = 'h1  h2'
    args = 'xCr_FCC xAl_FCC xFe_FCC xCr_BCC xAl_BCC xFe_BCC'
    function =(((1-xCr_FCC)*(1-xCr_FCC)*xCr_FCC*0.3664+xCr_FCC*xCr_FCC*xAl_FCC*1.2828+xCr_FCC*xCr_FCC*xFe_FCC*0.2251+xCr_FCC*xCr_FCC*(1-xCr_FCC-xAl_FCC-xFe_FCC)*0.5086)*h1+((1-xCr_BCC)*(1-xCr_BCC)*xCr_BCC*0.0029+xCr_BCC*xCr_BCC*xAl_BCC*185+xCr_BCC*xCr_BCC*xFe_BCC*0.0012+xCr_BCC*xCr_BCC*(1-xCr_BCC-xAl_BCC-xFe_BCC)*0.0013)*h2)
   f_name = M11
    outputs=exodus
  [../]

  [./M22]
    type = DerivativeParsedMaterial
    args = 'xCr_FCC xAl_FCC xFe_FCC xCr_BCC xAl_BCC xFe_BCC'
   material_property_names = 'h1  h2'
    function =(((1-xAl_FCC)*(1-xAl_FCC)*xAl_FCC*1.2828+xAl_FCC*xAl_FCC*xCr_FCC*0.3664+xAl_FCC*xAl_FCC*xFe_FCC*0.2251+xAl_FCC*xAl_FCC*(1-xCr_FCC-xAl_FCC-xFe_FCC)*0.5086)*h1+((1-xAl_BCC)*(1-xAl_BCC)*xAl_BCC*185+xAl_BCC*xAl_BCC*xCr_BCC*0.0029+xAl_BCC*xAl_BCC*xFe_BCC*0.0012+xAl_BCC*xAl_BCC*(1-xCr_BCC-xAl_BCC-xFe_BCC)*0.0013)*h2)
   f_name = M22
    outputs=exodus
  [../]

  [./M33]
    type = DerivativeParsedMaterial
    args = 'xCr_FCC xAl_FCC xFe_FCC  xCr_BCC xAl_BCC xFe_BCC'
   material_property_names = 'h1  h2'
    function =(((1-xFe_FCC)*(1-xFe_FCC)*xFe_FCC*0.2251+xFe_FCC*xFe_FCC*xAl_FCC*1.2828+xFe_FCC*xFe_FCC*xCr_FCC*0.3664+xFe_FCC*xFe_FCC*(1-xCr_FCC-xAl_FCC-xFe_FCC)*0.5086)*h1+((1-xFe_BCC)*(1-xFe_BCC)*xFe_BCC*0.0012+xFe_BCC*xFe_BCC*xAl_BCC*185+xFe_BCC*xFe_BCC*xCr_BCC*0.0029+xFe_BCC*xFe_BCC*(1-xCr_BCC-xAl_BCC-xFe_BCC)*0.0013)*h2)
    f_name = M33
    outputs=exodus
  [../]

   [./M12]
    type = DerivativeParsedMaterial
    args = 'xCr_FCC xAl_FCC xFe_FCC  xCr_BCC xAl_BCC xFe_BCC'
   material_property_names = 'h1  h2'
    function =(((-xCr_FCC)*(1-xAl_FCC)*xAl_FCC*1.2828+(1-xCr_FCC)*(-xAl_FCC)*xCr_FCC*0.3664+xCr_FCC*xAl_FCC*xFe_FCC*0.2251+xCr_FCC*xAl_FCC*(1-xCr_FCC-xAl_FCC-xFe_FCC)*0.5086)*h1+((-xCr_BCC)*(1-xAl_BCC)*xAl_BCC*185+(1-xCr_BCC)*(-xAl_BCC)*xCr_BCC*0.0029+xCr_BCC*xAl_BCC*xFe_BCC*0.0012+xCr_BCC*xAl_BCC*(1-xCr_BCC-xAl_BCC-xFe_BCC)*0.0013)*h2)
   f_name = M12
    outputs=exodus
  [../]

  [./M13]
    type = DerivativeParsedMaterial
    args = 'xCr_FCC xAl_FCC xFe_FCC    xCr_BCC xAl_BCC xFe_BCC'
   material_property_names = 'h1  h2'
    function =(((xFe_FCC)*(xCr_FCC)*xAl_FCC*1.2828+(-xFe_FCC)*(1-xCr_FCC)*xCr_FCC*0.3664+(1-xFe_FCC)*(-xCr_FCC)*xFe_FCC*0.2251+xFe_FCC*xCr_FCC*(1-xCr_FCC-xAl_FCC-xFe_FCC)*0.5086)*h1+((xFe_BCC)*(xCr_BCC)*xAl_BCC*185+(-xFe_BCC)*(1-xCr_BCC)*xCr_BCC*0.0029+(1-xFe_BCC)*(-xCr_BCC)*xFe_BCC*0.0012+xFe_BCC*xCr_BCC*(1-xCr_BCC-xAl_BCC-xFe_BCC)*0.0013)*h2)
    f_name = M13
    outputs=exodus
  [../]

  [./M23]
    type = DerivativeParsedMaterial
    args = 'xCr_FCC xAl_FCC xFe_FCC   xCr_BCC xAl_BCC xFe_BCC'
   material_property_names = 'h1  h2'
    function =(((-xFe_FCC)*(1-xAl_FCC)*xAl_FCC*1.2828+xFe_FCC*xAl_FCC*xCr_FCC*0.3664+(1-xFe_FCC)*(-xAl_FCC)*xFe_FCC*0.2251+xFe_FCC*xAl_FCC*(1-xCr_FCC-xAl_FCC-xFe_FCC)*0.5086)*h1+((-xFe_BCC)*(1-xAl_BCC)*xAl_BCC*185+xFe_BCC*xAl_BCC*xCr_BCC*0.0029+(1-xFe_BCC)*(-xAl_BCC)*xFe_BCC*0.0012+xFe_BCC*xAl_BCC*(1-xCr_BCC-xAl_BCC-xFe_BCC)*0.0013)*h2)
   f_name = M23
    outputs=exodus
  [../]
  []

[Kernels]
   #Kernels for CH equation
 [./CHBulk1]
    type = KKSSplitCHCRes
    variable = xCr
    ca       = xCr_FCC
    fa_name  = FFCC
    w        = w1
    args_a='xAl_FCC xFe_FCC'
  [../]

  [./dc1dt]
    type = CoupledTimeDerivative
    variable = w1
    v = xCr
  [../]

  [./w11kernel]
    type = SplitCHWRes
    mob_name = M11
    variable = w1
  [../]
  [./w12kernel]
    type = SplitCHWRes
    variable = w1
    w = w2
    mob_name = M12
  [../]
  [./w13kernel]
    type = SplitCHWRes
    variable = w1
    w = w3
    mob_name = M13
  [../]

   #Kernels for CH equation

 [./CHBulk2]
    type = KKSSplitCHCRes
    variable = xAl
    ca       = xAl_FCC
    fa_name  = FFCC
    w        = w2
    args_a='xCr_FCC xFe_FCC'
  [../]

  [./dc2dt]
    type = CoupledTimeDerivative
    variable = w2
    v = xAl
  [../]
  [./w21kernel]
    type = SplitCHWRes
    variable = w2
    w = w1
    mob_name = M12
  [../]
  [./w22kernel]
    type = SplitCHWRes
    mob_name = M22
    variable = w2
  [../]
  [./w23kernel]
    type = SplitCHWRes
    variable = w2
    w = w3
    mob_name = M23
  [../]

 #Kernels for CH equation
 [./CHBulk3]
    type = KKSSplitCHCRes
    variable = xFe
    ca       = xFe_FCC
    fa_name  = FFCC
    w        = w3
args_a='xAl_FCC xCr_FCC'
  [../]

  [./dc3dt]
    type = CoupledTimeDerivative
    variable = w3
    v = xFe
  [../]
  [./w31kernel]
    type = SplitCHWRes
    variable = w3
    w = w1
    mob_name = M13
  [../]
  [./w32kernel]
    type = SplitCHWRes
    variable = w3
    w = w2
    mob_name = M23
  [../]
  [./w33kernel]
    type = SplitCHWRes
    mob_name = M33
    variable = w3
  [../]

# gi is not used
  # Kernels for Allen-Cahn equation for eta1
  [./deta1dt]
    type = TimeDerivative
    variable = eta1
  [../]
  [./ACBulkFFCC]
    type = KKSMultiACBulkF
    variable  = eta1
    Fj_names  = 'FFCC  FBCC'
    hj_names  = 'h1 h2'
    gi_name   = g1
    eta_i     = eta1
    wi        = 0
    args='xCr_FCC xAl_FCC xFe_FCC eta2 xCr_BCC xAl_BCC xFe_BCC'
  [../]
  [./ACBulkC1]
    type = KKSMultiACBulkC
    variable  = eta1
    Fj_names  = 'FFCC FBCC'
    hj_names  = 'h1 h2'
    cj_names  = 'xCr_FCC xCr_BCC'
    eta_i     = eta1
    args= 'xAl_FCC xFe_FCC  xAl_BCC   xFe_BCC eta2'
  [../]
 [./ACBulkC2]
    type = KKSMultiACBulkC
    variable  = eta1
    Fj_names  = 'FFCC FBCC'
    hj_names  = 'h1 h2'
    cj_names  = 'xAl_FCC xAl_BCC'
    eta_i     = eta1
    args= 'xCr_FCC xFe_FCC  xCr_BCC xFe_BCC eta2'
  [../]
 [./ACBulkC3]
    type = KKSMultiACBulkC
    variable  = eta1
    Fj_names  = 'FFCC FBCC'
    hj_names  = 'h1 h2'
    cj_names  = 'xFe_FCC xFe_BCC'
    eta_i     = eta1
    args= 'xCr_FCC xAl_FCC  xCr_BCC xAl_BCC eta2'
  [../]
  [./ACGr1]
    type = ACGrGrMulti
    variable = eta1
    v = 'eta2'
    gamma_names = 'gamma12'
  [../]
  [./ACInterface1]
    type = ACInterface
    variable = eta1
    kappa_name = kappa
  [../]


  # Kernels for Allen-Cahn equation for eta2
  [./deta2dt]
    type = TimeDerivative
    variable = eta2
  [../]
  [./ACBulkFFCC2]
    type = KKSMultiACBulkF
    variable  = eta2
    Fj_names  = 'FFCC FBCC'
    hj_names  = 'h1 h2'
    gi_name   = g2
    eta_i     = eta2
    wi        = 0
args='xCr_FCC xAl_FCC xFe_FCC  xCr_BCC xAl_BCC xFe_BCC eta1'
  [../]

  [./ACBulkxCr_FCC]
    type = KKSMultiACBulkC
    variable  = eta2
    Fj_names  = 'FFCC  FBCC'
    hj_names  = 'h1 h2'
    cj_names  = 'xCr_FCC xCr_BCC'
    eta_i     = eta2
    args='xAl_FCC xFe_FCC  xAl_BCC xFe_BCC eta1'
  [../]

  [./ACBulkxAl_FCC]
    type = KKSMultiACBulkC
    variable  = eta2
    Fj_names  = 'FFCC FBCC'
    hj_names  = 'h1 h2'
    cj_names  = 'xAl_FCC xAl_BCC'
    eta_i     = eta2
    args='xCr_FCC xFe_FCC  xCr_BCC xFe_BCC eta1'
  [../]
  [./ACBulkxFe_FCC]
    type = KKSMultiACBulkC
    variable  = eta2
    Fj_names  = 'FFCC FBCC'
    hj_names  = 'h1 h2'
    cj_names  = 'xFe_FCC  xFe_BCC'
    eta_i     = eta2
    args='xCr_FCC xAl_FCC  xCr_BCC xAl_BCC eta1'
  [../]
 [./ACGr2]
    type = ACGrGrMulti
    variable = eta2
    v = 'eta1'
    gamma_names = 'gamma12'
  [../]
  [./ACInterface2]
    type = ACInterface
    variable = eta2
    kappa_name = kappa
  [../]
    [./chempot23]
    type = KKSPhaseChemicalPotential
    variable = xCr_FCC
    cb       = xCr_BCC
    fa_name  = FFCC
    fb_name  = FBCC
    args_a='xAl_FCC xFe_FCC'
    args_b='xAl_BCC xFe_BCC'
  [../]
  [./phaseconcentration1]
    type = KKSMultiPhaseConcentration
    variable = xCr_BCC
    cj = 'xCr_FCC xCr_BCC'
    hj_names = 'h1 h2'
    etas = 'eta1 eta2'
    c = xCr
  [../]

    [./chempot_23]
    type = KKSPhaseChemicalPotential
    variable = xAl_FCC
    cb       = xAl_BCC
    fa_name  = FFCC
    fb_name  = FBCC
    args_a='xCr_FCC xFe_FCC'
    args_b='xCr_BCC xFe_BCC'
  [../]
  [./phaseconcentration2]
    type = KKSMultiPhaseConcentration
    variable = xAl_BCC
    cj = 'xAl_FCC xAl_BCC'
    hj_names = 'h1 h2'
    etas = 'eta1 eta2'
    c = xAl
  [../]

  [./chempot_2_3]
    type = KKSPhaseChemicalPotential
    variable = xFe_FCC
    cb       = xFe_BCC
    fa_name  = FFCC
    fb_name  = FBCC
    args_a='xCr_FCC xAl_FCC'
    args_b='xCr_BCC xAl_BCC'
  [../]
  [./phaseconcentration3]
    type = KKSMultiPhaseConcentration
    variable = xFe_BCC
    cj = 'xFe_FCC xFe_BCC'
    hj_names = 'h1 h2'
    etas = 'eta1 eta2'
    c = xFe
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'

  petsc_options_iname = '-pc_type -sub_pc_type   -sub_pc_factor_shift_type'
  petsc_options_value = 'asm       lu            nonzero'

  l_max_its = 100
  nl_max_its = 100
  l_tol = 1.0e-6
  nl_rel_tol = 1.0e-10
  nl_abs_tol = 1.0e-11

   start_time = 0.0
   end_time = 8640000.0
  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 10
    cutback_factor = 0.8
    growth_factor = 1.5
    optimal_iterations = 7
  [../]
[]
#

[Preconditioning]
  active = 'full'
  [./full]
    type = SMP
    full = true
  [../]
  [./mydebug]
    type = FDP
    full = true
  [../]
[]

#Debugging
[Debug]
show_var_residual_norms=true
[]

[Outputs]
exodus = true
checkpoint = true
  interval=100
  [./restart]
    type = Checkpoint
    num_files = 500
  [../]
[]
