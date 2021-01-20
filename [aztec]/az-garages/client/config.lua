vAZ.config = {}

vAZ.config.marker = { r = 186, g = 51, b = 212 }
vAZ.config.class = {
	13
--[[
	0: Compacts  
	1: Sedans  
	2: SUVs  
	3: Coupes  
	4: Muscle  
	5: Sports Classics  
	6: Sports  
	7: Super  
	8: Motorcycles  
	9: Off-road  
	10: Industrial  
	11: Utility  
	12: Vans  
	13: Cycles
	14: Boats  
	15: Helicopters  
	16: Planes  
	17: Service  
	18: Emergency  
	19: Military  
	20: Commercial  
	21: Trains
]]--
}

vAZ.config.garages = {}
vAZ.config.garages.service = {
	[1] = {
		name = 'Garagem Civil',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 456.51, ['y'] = -1010.52, ['z'] = 28.37 }  -- 456.51,-1010.52,28.37
		},
		spaces = {
			{ ['x'] = 450.09, ['y'] = -1019.05, ['z'] = 28.5, ['h'] = 90.52 }, -- 450.09,-1019.05,28.5
		--	{ ['x'] = -472.84, ['y'] = 6035.33, ['z'] = 31.35, ['h'] = 222.97 },
		}
	},
	[2] = {
		name = 'Garagem Rota',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1867.2, ['y'] = 3687.9, ['z'] = 34.27 }  -- 1867.2,3687.9,34.27
		},
		spaces = {
            { ['x'] = 1853.21, ['y'] = 3676.22, ['z'] = 33.79, ['h'] = 210.81 },  -- 1853.21,3676.22,33.79
		}
	},
	[3] = {
		name = 'Garagem RP',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1865.04, ['y'] = 3686.68, ['z'] = 34.27 }   -- 1865.04,3686.68,34.27
		},
		spaces = {
            { ['x'] = 1853.21, ['y'] = 3676.22, ['z'] = 33.79, ['h'] = 210.81 },  -- 1853.21,3676.22,33.79
		}
	},
	[4] = {
		name = 'Garagem CMD',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1862.58, ['y'] = 3685.21, ['z'] = 34.27 }    -- 1862.58,3685.21,34.27
		},
		spaces = {
            { ['x'] = 1853.21, ['y'] = 3676.22, ['z'] = 33.79, ['h'] = 210.81 },  -- 1853.21,3676.22,33.79
		}
	},
	[5] = {
		name = 'Garagem PoliciaH',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 459.34, ['y'] = -977.25, ['z'] = 43.7 } -- HELI PM
		},
		spaces = {
            { ['x'] = 450.47, ['y'] = -981.13, ['z'] = 43.7, ['h'] = 87.65 },
		}
	},
--[[	[6] = {
		name = 'Garagem PoliciaH',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -461.72, ['y'] = 5974.31, ['z'] = 31.33 }
		},
		spaces = {
            { ['x'] = -475.55, ['y'] = 5988.38, ['z'] = 31.73, ['h'] = 314.37 },
		}
	},]]
	[7] = {
		name = 'Garagem Paramedico',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -450.86, ['y'] = -351.15, ['z'] = 34.50 }
		},
		spaces = {
			{ ['x'] = -503.16, ['y'] = -314.71, ['z'] = 73.16, ['h'] = 70.0 }
		}
	},
	[8] = {
		name = 'Garagem Weazel',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -537.15, ['y'] = -886.54, ['z'] = 25.21 }
		},
		spaces = {
            { ['x'] = -544.0, ['y'] = -900.64, ['z'] = 23.93, ['h'] = 168.44 }
		}
	},
	[10] = {
		name = 'Garagem ParamedicoH',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -495.63, ['y'] = -323.63, ['z'] = 73.16 }  -- HELI SAMU
		},
		spaces = {
            { ['x'] = -503.16, ['y'] = -314.71, ['z'] = 73.16, ['h'] = 232.53 }
		}
	},
	[11] = {
		name = 'Garagem Mecanico',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 888.97, ['y'] = -1028.11, ['z'] = 35.12 }
		},
		spaces = {
            { ['x'] = 901.23, ['y'] = -1024.85, ['z'] = 34.96, ['h'] = 4.15 }
		}
	},
	[12] = {
		name = 'Garagem Mecanico',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 105.27, ['y'] = 6613.66, ['z'] = 32.4 }
		},
		spaces = {
            { ['x'] = 119.28, ['y'] = 6599.33, ['z'] = 32.08, ['h'] = 270.26 }
		}
	},
	[13] = {
		name = 'Garagem Uber',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 897.02, ['y'] = -179.44, ['z'] = 73.73 }
		},
		spaces = {
            { ['x'] = 907.85, ['y'] = -175.75, ['z'] = 74.15, ['h'] = 250.27 }
		}
	},
	[14] = {
		name = 'Garagem Juiz',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 472.11, ['y'] = -1078.14, ['z'] = 29.36 }
		},
		spaces = {
            { ['x'] = 472.3, ['y'] = -1089.12, ['z'] = 28.61, ['h'] = 269.43 }
		}
	},
	[15] = {
		name = 'Garagem Advogado',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 472.01, ['y'] = -1114.81, ['z'] = 29.4 }
		},
		spaces = {
            { ['x'] = 472.49, ['y'] = -1109.19, ['z'] = 28.58, ['h'] = 269.43 }
		}
	},
	[16] = {
		name = 'Garagem FT',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1860.77, ['y'] = 3684.13, ['z'] = 34.27 }   --  1860.77,3684.13,34.27
		},
		spaces = {
            { ['x'] = 1853.21, ['y'] = 3676.22, ['z'] = 33.79, ['h'] = 210.81 },  -- 1853.21,3676.22,33.79
		}
	},
	[17] = {
		name = 'Garagem Motoclub',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 884.88, ['y'] = -2106.94, ['z'] = 30.76 }
		},
		spaces = {
         	{ ['x'] = 884.37, ['y'] = -2102.16, ['z'] = 30.08, ['h'] = 265.01 },
			{ ['x'] = 884.37, ['y'] = -2098.97, ['z'] = 30.08, ['h'] = 265.01 }
		}
	},
	[18] = {
		name = 'Garagem Motoclub',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 984.35, ['y'] = -130.82, ['z'] = 73.15 }
		},
		spaces = {
            { ['x'] = 977.63, ['y'] = -126.85, ['z'] = 73.87, ['h'] = 61.62 }
		}
	},
	[19] = {
		name = 'Garagem Yakuza',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -809.75, ['y'] = -577.90, ['z'] = 30.13 }
		},
		spaces = {
			{ ['x'] = -811.38, ['y'] = -574.50, ['z'] = 29.50, ['h'] = 299.03 },
			{ ['x'] = -813.64, ['y'] = -571.33, ['z'] = 29.50, ['h'] = 299.03 }
		}
	},
	[20] = {
		name = 'Garagem Motoclub',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 137.12, ['y'] = 2292.02, ['z'] = 94.08 }
		},
		spaces = {
			{ ['x'] = 135.01, ['y'] = 2278.94, ['z'] = 95.18, ['h'] = 61.62 }
		}
	},
	[21] = {
		name = 'Garagem Piloto',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -68.14, ['y'] = -810.86, ['z'] = 326.18 }
		},
		spaces = {
			{ ['x'] = -76.04, ['y'] = -818.62, ['z'] = 326.18, ['h'] = 3241.48 }
		}
	},
	[22] = {
		name = 'Garagem VIP HELI A.D.A',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},  -- 1720.06,1076.5,155.14
		point = {
			{ ['x'] = 1720.06, ['y'] = 1076.5, ['z'] = 155.14 }
		},
		spaces = {
			{ ['x'] = 1714.5, ['y'] = 1067.66, ['z'] = 154.95, ['h'] = 156.94 }  -- 1714.5,1067.66,154.95
		}
	},
	[23] = {
		name = 'Garagem VIP HELI C.V',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1423.92, ['y'] = -721.98, ['z'] = 82.45 }    -- 1423.92,-721.98,82.45
		},
		spaces = {
			{ ['x'] = 1432.48, ['y'] = -726.75, ['z'] = 82.28, ['h'] = 257.89 }    -- 1432.48,-726.75,82.28
		}
	},
	[24] = {
		name = 'Garagem VIP HELI P.C.C',  
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 567.89, ['y'] = 430.52, ['z'] = 174.35 }    -- 567.89,430.52,174.35
		},
		spaces = {
			{ ['x'] = 558.28, ['y'] = 432.98, ['z'] = 174.19, ['h'] = 87.37 }    -- 558.28,432.98,174.19
		}
	},
	[25] = {
		name = 'Garagem VIP HELI T.C.P', -- -113.61,2228.08,160.82
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -113.61, ['y'] = 2228.08, ['z'] = 160.82 }
		},
		spaces = {
			{ ['x'] = -104.17, ['y'] = 2233.35, ['z'] = 160.61, ['h'] = 263.66 }  -- -104.17,2233.35,160.61
		}
	},
	[26] = {
		name = 'Garagem VIP HELI F.D.N',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 349.53, ['y'] = 1912.13, ['z'] = 171.61 }
		},
		spaces = {
			{ ['x'] = 357.94, ['y'] = 1918.47, ['z'] = 171.42, ['h'] = 318.31 }  -- 357.94,1918.47,171.42
		}
	},
	[27] = {
		name = 'Garagem VIP HELI OKAIDA',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -634.8, ['y'] = 1967.23, ['z'] = 172.82 }
		},
		spaces = {
			{ ['x'] = 1432.48, ['y'] = -726.75, ['z'] = 82.28, ['h'] = 257.89 }    -- 1432.48,-726.75,82.28
		}
	},
	[28] = {
		name = 'Garagem Motorista',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 453.89, ['y'] = -600.57, ['z'] = 28.58 }
		},
		spaces = {
			{ ['x'] = 462.51, ['y'] = -605.27, ['z'] = 29.32, ['h'] = 214.04 },
			{ ['x'] = 461.44, ['y'] = -611.34, ['z'] = 29.33, ['h'] = 214.04 }
		}
	},
	[29] = {
		name = 'Garagem Carteiro',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 69.09, ['y'] = 127.27, ['z'] = 79.21 }
		},
		spaces = {
			{ ['x'] = 69.94, ['y'] = 121.84, ['z'] = 79.17, ['h'] = 158.92 },
		--	{ ['x'] = -403.27, ['y'] = 6165.49, ['z'] = 31.43, ['h'] = 353.74 }
		}
	},
	[30] = {
		name = 'Garagem Lixeiro',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -341.58, ['y'] = -1567.46, ['z'] = 25.22 }
		},
		spaces = {
			{ ['x'] = -342.17, ['y'] = -1560.10, ['z'] = 25.23, ['h'] = 100.0 }
		}
	},
	[31] = {
		name = 'Garagem Minerador',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1054.13, ['y'] = -1952.76, ['z'] = 32.09 }
		},
		spaces = {
			{ ['x'] = 1074.33, ['y'] = -1964.17, ['z'] = 31.10, ['h'] = 55.04 },
			{ ['x'] = 1073.10, ['y'] = -1951.72, ['z'] = 31.10, ['h'] = 144.83 }
		}
	},
	[32] = {
		name = 'Garagem Lenhador',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1200.41, ['y'] = -1276.48, ['z'] = 35.22 }
		},
		spaces = {
			{ ['x'] = 1212.45, ['y'] = -1273.60, ['z'] = 34.93, ['h'] = 85.64 },
			{ ['x'] = 1212.11, ['y'] = -1278.50, ['z'] = 34.93, ['h'] = 85.64 }
		}
	},
	[33] = {
		name = 'Garagem Leiteiro',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 173.10, ['y'] = -26.00, ['z'] = 68.34 }
		},
		spaces = {
			{ ['x'] = 171.91, ['y'] = -35.42, ['z'] = 67.97, ['h'] = 182.07 },
			{ ['x'] = 166.26, ['y'] = -33.42, ['z'] = 67.86, ['h'] = 182.07 }
		}
	},
	[34] = {
		name = 'Garagem Caminhoneiro',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1196.80, ['y'] = -3253.68, ['z'] = 7.09 }
		},
		spaces = {
			{ ['x'] = 1185.20, ['y'] = -3251.40, ['z'] = 6.02, ['h'] = 91.07 }
		}
	},
	[35] = {
		name = 'Garagem Embarcações',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -1605.19, ['y'] = -1164.37, ['z'] = 1.28 }
		},
		spaces = {
			{ ['x'] = -1619.61, ['y'] = -1175.78, ['z'] = -0.08, ['h'] = 130.0 }
		}
	},
	[36] = {
		name = 'Garagem Embarcações',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -1522.68, ['y'] = 1494.92, ['z'] = 111.58 }
		},
		spaces = {
			{ ['x'] = -1526.63, ['y'] = 1499.64, ['z'] = 109.08, ['h'] = 350.0 }
		}
	},
	[37] = {
		name = 'Garagem Embarcações',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1337.36, ['y'] = 4269.71, ['z'] = 31.50 }
		},
		spaces = {
			{ ['x'] = 1343.24, ['y'] = 4269.59, ['z'] = 30.11, ['h'] = 190.0 }
		}
	},
	[38] = {
		name = 'Garagem Embarcações',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -192.32, ['y'] = 791.54, ['z'] = 198.10 }
		},
		spaces = {
			{ ['x'] = -195.95, ['y'] = 788.35, ['z'] = 195.93, ['h'] = 230.0 }
		}
	},
	[39] = {
		name = 'Garagem Ifood',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 145.88, ['y'] = -1464.65, ['z'] = 29.36 }
		},
		spaces = {
			{ ['x'] = 147.59, ['y'] = -1460.43, ['z'] = 29.1, ['h'] = 47.19 }
		}
	},
	[40] = {
		name = 'Garagem Carteiro',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -414.03, ['y'] = 6171.54, ['z'] = 31.48 }
		},
		spaces = {
			{ ['x'] = -400.42, ['y'] = 6162.68, ['z'] = 31.38, ['h'] = 353.74 },
			{ ['x'] = -403.27, ['y'] = 6165.49, ['z'] = 31.43, ['h'] = 353.74 }
		}
	},
	[41] = {
		name = 'Garagem Eletricista',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = -816.52, ['y'] = -742.15, ['z'] = 23.79 }
		},
		spaces = {
			{ ['x'] = -817.45, ['y'] = -749.45, ['z'] = 23.08, ['h'] = 91.42 }
		}
	},
	[42] = {
		name = 'Garagem VIP HELI CARTEL',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1525.91, ['y'] = 1679.48, ['z'] = 112.07 }  -- 1525.91,1679.48,112.07
		},
		spaces = {
			{ ['x'] = 1523.82, ['y'] = 1670.695, ['z'] = 111.77, ['h'] = 180.11 }  -- 1523.82,1670.69,111.77
		}
	},
	[43] = {
		name = 'Garagem VIP HELI GROTTA',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1823.73, ['y'] = 3442.67, ['z'] = 42.54 }  -- 1823.73,3442.67,42.54
		},
		spaces = {
			{ ['x'] = 1831.92, ['y'] = 3447.07, ['z'] = 42.35, ['h'] = 267.97 }  -- 1831.92,3447.07,42.35
		}
	},
	[44] = {
		name = 'Garagem VIP HELI MOTOCLUB',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ ['x'] = 1017.51, ['y'] = -136.72, ['z'] = 83.25 }   -- 1017.51,-136.72,83.25
		},
		spaces = {
			{ ['x'] = 1023.19, ['y'] = -145.72, ['z'] = 83.04, ['h'] = 226.85 }    -- 1023.19,-145.72,83.04
		}
	}
}

vAZ.config.garages.rental = {
	[1] = {
		name = 'Bicicletario',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 116.38, y = -1088.75, z = 29.23 },
		},
		spaces = {
            { x = 117.72, y = -1082.50, z = 28.58, h = 350.90 }
		}
	},
	[2] = {
		name = 'Bicicletario',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -1172.23, y = -1572.0, z = 4.67 },
		},
		spaces = {
            { x = -1187.28, y = -1573.2, z = 3.71, h = 305.88 }
		}
	},
	[3] = {
		name = 'Bicicletario',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -1030.58	, y = -2728.32, z = 13.76 },
		},
		spaces = {
			{ x = -1039.31, y = -2720.59, z = 13.65, h = 327.21 },
			{ x = -1041.1, y = -2719.37, z = 13.65, h = 331.68 },
			{ x = -1042.67, y = -2718.21, z = 13.67, h = 327.26 },
			{ x = -1025.53, y = -2727.94, z = 13.67, h = 331.13 },
		}
	},
	[4] = {
		name = 'Colheita',
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 448.15, y = 6462.45, z = 28.99 },
		},
		spaces = {
            { x = 448.85, y = 6454.48, z = 29.3, h = 256.35 },
			{ x = 444.74, y = 6448.56, z = 29.61, h = 272.94 },
		}
	},
}

vAZ.config.garages.private = {}

vAZ.config.garages.personal = {
	[1] = {
		name = 'Garagem Pública 01',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 55.46, y = -876.29, z = 30.66 },
		},
		spaces = {
            { x = 50.92, y = -872.96, z = 30.44, h = 339.16 },
            { x = 47.28, y = -872.43, z = 30.44, h = 339.160 },
            { x = 44.22, y = -871.12, z = 30.45, h = 339.16 }
		}
    },
    [2] ={
		name = 'Garagem Pública 02',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -796.53, y = -2022.86, z = 9.16 }
		},
		spaces = {
            { x = -779.54870605469, y = -2039.6900634766, z = 8.2545862197876, h = 135.41 },
            { x = -776.98803710938, y = -2042.1787109375, z = 8.2597703933716, h = 135.4 },
			{ x = -772.14984130859, y = -2047.1433105469, z = 8.2667007446289, h = 135.4 },
			{ x = -775.88525390625, y = -2025.103515625, z = 8.2463073730469, h = 35.48 },
			{ x = -770.10540771484, y = -2020.7385253906, z = 8.2489585876465, h = 35.48 },			
		}
	},
	[3] ={
		name = 'Garagem Pública 03',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 317.25, y = 2623.14, z = 44.46 }
		},
		spaces = {
            { x = 334.52, y = 2623.09, z = 44.49, h = 20.0 }
		}
	},		
	[4] ={
		name = 'Garagem Pública 04',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -773.34, y = 5598.15, z = 33.60 }
		},
		spaces = {
            { x = -772.82, y = 5578.48, z = 33.48, h = 89.01 }
		}
	},		
	[5] ={
		name = 'Garagem Pública 05',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 275.23, y = -345.54, z = 45.17 }
		},
		spaces = {
            { x = 285.05, y = -339.29, z = 44.91, h = 249.0 }
		}
	},
	[6] ={
		name = 'Garagem Pública 06',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -986.05, y = 585.95, z = 102.34 }
		},
		spaces = {
            { x = -985.25, y = 592.11, z = 102.25, h = 70.0 }
		}
	},
	[7] ={
		name = 'Garagem Pública 07',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -340.76, y = 265.97, z = 85.67 }
		},
		spaces = {
            { x = -328.80, y = 277.92, z = 86.34, h = 95.0 }
		}
	},
	[8] ={
		name = 'Garagem Pública 08',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -2020.00, y = -463.16, z = 14.29 }
		},
		spaces = {
            { x = -2024.27, y = -471.93, z = 11.40, h = 140.0 }
		}
	},
	[9] ={
		name = 'Garagem Pública 09',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -1184.92, y = -1510.00, z = 4.64 }
		},
		spaces = {
            { x = -1186.70, y = -1490.54, z = 4.37, h = 125.0 }
		}
	},
	[10] ={
		name = 'Garagem Pública 10',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -73.44, y = -2004.99, z = 18.27 }
		},
		spaces = {
            { x = -84.96, y = -2004.22, z = 18.01, h = 352.0 }
		}
	},
	[11] ={
		name = 'Garagem Pública 11',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 214.02, y = -808.44, z = 31.01 }
		},
		spaces = {
			{ x = 219.91, y = -808.99, z = 30.17, h = 68.69 },
			{ x = 221.65, y = -804.03, z = 30.17, h = 68.55 },
			{ x = 222.93, y = -801.61, z = 30.15, h = 68.55	},
			{ x = 223.97, y = -799.12, z = 30.15, h = 68.48 },
			{ x = 225.15, y = -796.70, z = 30.15, h = 69.74 },
			{ x = 233.05, y = -805.26, z = 29.94, h = 246.77 },
			{ x = 234.12, y = -802.89, z = 29.95, h = 248.71 },
			{ x = 234.88, y = -800.40, z = 29.96, h = 248.55 },
		}
	},
	[12] ={
		name = 'Garagem Pública 12',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -348.88, y = -874.02, z = 31.31 }
		},
		spaces = {
            { x = -334.58, y = -891.73, z = 31.07, h = 345.0 }
		}
	},
	[13] ={
		name = 'Garagem Pública 13',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -1285.93, y = 623.55, z = 139.14 }
			},
		spaces = {
	        { x = -1291.86, y = 630.45, z = 137.99, h = 339.38 }
		}
	},
	[14] ={
		name = 'Garagem Pública 14',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{  x = 361.90, y = 297.81, z = 103.88 }
		},
		spaces = {
            { x = 371.18, y = 284.78, z = 103.25, h = 338.86 }
		}
	},
	[15] ={
		name = 'Garagem Pública 15',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{  x = 101.18, y = -1073.75, z = 29.37 }
		},
		spaces = {
			{ x = 105.99758911133, y = -1062.9788818359, z = 28.701293945313, h = 66.06 },
			{ x = 107.55735778809, y = -1059.4870605469, z = 28.700958251953, h = 66.94 },
			{ x = 110.49443817139, y = -1052.9060058594, z = 28.703485488892, h = 66.09 },
			{ x = 118.98513031006, y = -1069.9261474609, z = 28.685474395752, h = 178.83 },
			{ x = 125.71153259277, y = -1070.3876953125, z = 28.686025619507, h = 180.34 },
			{ x = 121.16877746582, y = -1081.7236328125, z = 28.686029434204, h = 178.81 },
			{ x = 107.77198791504, y = -1079.4542236328, z = 28.685680389404, h = 160.33 }
		}
	},
--[[	[16] ={
		name = 'Garagem Pública 16',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 948.47, y = -1010.61, z = 42.01 }
		},
		spaces = {
			{ x = 966.37, y = -1031.09, z = 40.21, h = 268.51 },
			{ x = 966.92, y = -1025.36, z = 40.22, h = 270.25 },
			{ x = 966.71, y = -1019.84, z = 40.22, h = 269.07 },
			{ x = 966.28, y = -1013.74, z = 40.22, h = 269.41 }
		}
	},]]
	[18] ={
		name = 'Garagem Pública 17',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -72.63, y = 908.86, z = 235.62 }
		},
		spaces = {
			{ x = -71.34, y = 903.20, z = 235.34, h = 112.02 },
			{ x = -70.74, y = 899.99, z = 235.30, h = 112.75 },
			{ x = -69.59, y = 897.15, z = 235.24, h = 114.17 },
			{ x = -67.95, y = 894.72, z = 235.26, h = 114.75 },
			{ x = -66.93, y = 891.60, z = 235.28, h = 116.17 }
		}
	},
	[19] ={
		name = 'Garagem Pública 18',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -3252.51, y = 981.84, z = 12.60 }
		},
		spaces = {
			{ x = -3253.168, y = 987.23, z = 11.83, h = 182.44 },
			{ x = -3249.60, y = 987.46, z = 11.85, h = 183.60 },
			{ x = -3245.82, y = 987.92, z = 11.86, h = 183.96 },
			{ x = -3241.94, y = 988.12, z = 11.85, h = 181.32 }
		}
	},
	[20] ={
		name = 'Garagem Pública 19',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 2834.65, y = 2806.81, z = 57.40 }
		},
		spaces = {
			{ x = 2830.14, y = 2808.18, z = 56.77, h = 177.86 },
			{ x = 2827.28, y = 2808.19, z = 56.74, h = 180.79 },
		}
	},	
	[21] ={
		name = 'Garagem Pública 20',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -177.75, y = -1295.01, z = 31.35 }
		},
		spaces = {
			{ x = -191.11, y = -1290.34, z = 31.29, h = 266.818 },
			{ x = -191.47, y = -1284.56, z = 31.23, h = 272.052 },
		}
	},	
	[22] ={
		name = 'Garagem Pública 21',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -1195.66, y = -1745.66, z = 4.44 }
		},
		spaces = {
			{ x = -1173.04, y = -1747.03, z = 3.98, h = 308.65 }
		}
	},
--[[	[23] ={
		name = 'Garagem Pública 22',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 959.17, y = -121.07, z = 74.96 }
		},
		spaces = {
			{ x = 968.42, y = -126.76, z = 74.36, h = 339.16 }
		}
	},]]
	[24] ={
		name = 'Garagem Pública 23',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -170.15, y = 965.03, z = 237.34 }
		},
		spaces = {
			{ x = -169.61, y = 969.91, z = 236.96, h =  223.5 }
		}
	},
	[25] ={
		name = 'Garagem Pública 24',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -955.27, y = -1485.87, z = 5.16 }
		},
		spaces = {
			{ x = -963.40, y = -1495.85, z = 5.01, h =  223.5 }
		}
	},
	[26] ={
		name = 'Garagem Pública 25',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 804.54, y = 1162.03, z = 321.17 }
		},
		spaces = {
			{ x = 811.19, y = 1160.70, z = 320.03, h =  223.5 }
		}
	},
	[27] ={
		name = 'Garagem Pública 26',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 1498.80, y = -1699.93, z = 88.19 }
		},
		spaces = {
			{ x = 1499.74, y = -1690.64, z = 88.19, h =  223.5 }
		}
	},
	[28] ={
		name = 'Garagem Pública 27', -- cv
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -795.37, y = 596.60, z = 127.27 }
		},
		spaces = {
			{ x = 1499.74, y = -1690.64, z = 88.19, h =  223.5 }
		}
	},
	[29] ={
		name = 'Garagem Pública 28', 
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 69.68, y = 3629.56, z = 39.41 }
		},
		spaces = {
			{ x = 66.21, y = 3639.79, z = 39.67, h =  223.5 }
		}
	},
	[30] ={
		name = 'Garagem Pública 29', 
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 702.71, y = 3084.10, z = 44.11 }
		},
		spaces = {
			{ x = 704.41, y = 3090.42, z = 44.24, h =  223.5 }
		}
	},
--[[	[31] ={
		name = 'Garagem Pública 30', 
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -2636.45, y = 1322.46, z = 143.59 }
		},
		spaces = {
			{ x = -2631.94, y = 1326.53, z = 143.26, h =  223.5 }
		}
	},]]
	[32] ={
		name = 'Garagem Pública 31', 
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = 963.88, y = -1019.88, z = 40.85 }
		},
		spaces = {
			{ x = 972.97, y = -1020.48, z = 40.99, h =  273.41 }
		}
	},
	[33] ={
		name = 'Garagem Pública 33', 
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -843.13, y = -1240.34, z = 6.94 }
		},
		spaces = {
			{ x = -839.31, y = -1231.64, z = 6.94, h =  46.38 }
		}
	},
	[34] ={
		name = 'Garagem Da PRF', 
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -2505.2534179688, y = 3614.5676269531, z = 13.92223072052 }
		},
		spaces = {
			{ x = -2504.0187988281, y = 3625.455078125, z = 13.747188568115, h =  223.5 }
		}
	},
	[35] ={
		name = 'Garagem Aeroporto',
		type = 'personal',
		availables = {'car', 'motorcycle'},
		marker = 36,
		blip = {color = 4, scale = 0.4, type = 357},
		point = {
			{ x = -1023.21, y = -2732.90, z = 13.75 }
		},
		spaces = {
			{ x = -1018.53, y = -2731.05, z = 13.70, h = 266.818 },
		}
	}
}

vAZ.config.garages.home = {
	[1] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 119.47, z = 55.46, x = -835.07}
		},
		name = 'LX12',
		spaces = {
			{y = 112.3, z = 54.43, h = 210.36, x = -839.12}
		}
	},
	[2] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 299.58, z = 66.0, x = -1058.75}
		},
		name = 'LX13',
		spaces = {
			{y = 305.25, z = 65.13, h = 353.81, x = -1061.49}
		}
	},
	[3] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 267.95, z = 86.2, x = -827.87}
		},
		name = 'LX14',
		spaces = {
			{y = 273.44, z = 85.68, h = 342.78, x = -824.72}
		}
	},
	[4] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 322.71, z = 83.97, x = -869.56}
		},
		name = 'LX15',
		spaces = {
			{y = 317.83, z = 83.13, h = 186.23, x = -870.29}
		}
	},
	[5] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 360.73, z = 85.04, x = -887.96}
		},
		name = 'LX16',
		spaces = {
			{y = 367.35, z = 84.55, h = 3.4, x = -888.36}
		}
	},
	[6] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 363.75, z = 71.36, x = -1026.73}
		},
		name = 'LX17',
		spaces = {
			{y = 360.01, z = 70.05, h = 331.43, x = -1011.08}
		}
	},
	[7] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 426.75, z = 109.62, x = -1555.85}
		},
		name = 'LX18',
		spaces = {
			{y = 426.58, z = 109.09, h = 272.82, x = -1547.98}
		}
	},
	[8] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 274.79, z = 69.51, x = -1211.88}
		},
		name = 'LX19',
		spaces = {
			{y = 267.12, z = 68.69, h = 284.35, x = -1204.83}
		}
	},
	[9] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 354.46, z = 68.48, x = -1101.71}
		},
		name = 'LX20',
		spaces = {
			{y = 360.3, z = 67.69, h = 357.45, x = -1096.63}
		}
	},
	[10] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 18.76, z = 54.71, x = -1490.24}
		},
		name = 'LX21',
		spaces = {
			{y = 23.07, z = 53.88, h = 354.88, x = -1490.16}
		}
	},
	[11] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -50.22, z = 54.65, x = -1457.65}
		},
		name = 'LX22',
		spaces = {
			{y = -55.37, z = 52.6, h = 240.6, x = -1455.68}
		}
	},
	[12] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 19.84, z = 56.4, x = -1504.43}
		},
		name = 'LX23',
		spaces = {
			{y = 26.86, z = 55.15, h = 8.38, x = -1503.75}
		}
	},
	[13] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -81.3, z = 54.2, x = -1581.46}
		},
		name = 'LX24',
		spaces = {
			{y = -86.02, z = 53.29, h = 270.66, x = -1577.19}
		}
	},
	[14] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -55.63, z = 56.48, x = -1585.69}
		},
		name = 'LX25',
		spaces = {
			{y = -61.06, z = 55.64, h = 270.18, x = -1582.02}
		}
	},
	[15] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 17.86, z = 58.83, x = -1558.52}
		},
		name = 'LX26',
		spaces = {
			{y = 22.78, z = 57.7, h = 347.5, x = -1552.69}
		}
	},
	[16] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 14.71, z = 62.17, x = -1616.73}
		},
		name = 'LX27',
		spaces = {
			{y = 20.02, z = 61.32, h = 335.94, x = -1613.07}
		}
	},
	[17] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 120.59, z = 81.64, x = -1892.99}
		},
		name = 'LX28',
		spaces = {
			{y = 123.26, z = 80.86, h = 338.84, x = -1887.23}
		}
	},
	[18] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 179.1, z = 84.66, x = -1940.13}
		},
		name = 'LX29',
		spaces = {
			{y = 182.84, z = 83.68, h = 307.83, x = -1932.93}
		}
	},
	[19] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 296.59, z = 91.76, x = -2000.65}
		},
		name = 'LX32',
		spaces = {
			{y = 290.29, z = 90.85, h = 221.21, x = -1994.21}
		}
	},
	[20] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 381.84, z = 94.49, x = -2000.61}
		},
		name = 'LX33',
		spaces = {
			{y = 378.0, z = 94.49, h = 267.46, x = -1996.29}
		}
	},
	[21] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 453.64, z = 102.67, x = -2013.18}
		},
		name = 'LX34',
		spaces = {
			{y = 454.86, z = 101.79, h = 276.63, x = -2006.95}
		}
	},
	[22] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 485.7, z = 107.18, x = -2016.62}
		},
		name = 'LX35',
		spaces = {
			{y = 482.71, z = 106.07, h = 255.38, x = -2011.39}
		}
	},
	[23] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 192.09, z = 84.29, x = -1868.36}
		},
		name = 'LX36',
		spaces = {
			{y = 194.45, z = 83.77, h = 126.46, x = -1874.17}
		}
	},
	[24] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 241.7, z = 86.26, x = -1899.62}
		},
		name = 'LX37',
		spaces = {
			{y = 242.14, z = 85.6, h = 27.89, x = -1904.45}
		}
	},
	[25] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 285.25, z = 89.07, x = -1918.91}
		},
		name = 'LX38',
		spaces = {
			{y = 283.01, z = 88.23, h = 182.84, x = -1925.28}
		}
	},
	[26] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 366.09, z = 93.82, x = -1935.69}
		},
		name = 'LX39',
		spaces = {
			{y = 360.31, z = 92.55, h = 160.68, x = -1940.58}
		}
	},
	[27] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 386.17, z = 96.5, x = -1938.82}
		},
		name = 'LX40',
		spaces = {
			{y = 385.19, z = 95.6, h = 96.89, x = -1943.95}
		}
	},
	[28] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 462.55, z = 102.42, x = -1937.4}
		},
		name = 'LX41',
		spaces = {
			{y = 462.9, z = 101.12, h = 99.05, x = -1947.37}
		}
	},
	[29] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 322.6, z = 88.72, x = -1856.34}
		},
		name = 'LX42',
		spaces = {
			{y = 328.42, z = 87.8, h = 11.41, x = -1857.45}
		}
	},
	[30] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 345.73, z = 88.55, x = -1789.94}
		},
		name = 'LX43',
		spaces = {
			{y = 353.87, z = 87.72, h = 64.22, x = -1790.72}
		}
	},
	[31] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 368.33, z = 89.72, x = -1745.31}
		},
		name = 'LX44',
		spaces = {
			{y = 365.56, z = 88.85, h = 114.91, x = -1750.77}
		}
	},
	[32] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 385.25, z = 89.49, x = -1665.21}
		},
		name = 'LX45',
		spaces = {
			{y = 391.43, z = 88.39, h = 9.57, x = -1663.42}
		}
	},
	[33] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 456.14, z = 128.3, x = -1785.52}
		},
		name = 'LX46',
		spaces = {
			{y = 459.4, z = 127.46, h = 98.09, x = -1794.11}
		}
	},
	[34] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 605.61, z = 117.9, x = -1991.66}
		},
		name = 'LX47',
		spaces = {
			{y = 602.72, z = 117.28, h = 238.48, x = -1985.63}
		}
	},
	[35] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 529.39, z = 110.73, x = -1937.7}
		},
		name = 'LX48',
		spaces = {
			{y = 521.99, z = 108.31, h = 71.0, x = -1944.07}
		}
	},
	[36] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 624.88, z = 122.53, x = -1977.58}
		},
		name = 'LX50',
		spaces = {
			{y = 620.69, z = 121.14, h = 246.1, x = -1971.35}
		}
	},
	[37] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 919.61, z = 235.65, x = -165.4}
		},
		name = 'LX51',
		spaces = {
			{y = 926.68, z = 234.8, h = 234.16, x = -162.36}
		}
	},
	[38] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 966.12, z = 237.53, x = -172.67}
		},
		name = 'LX52',
		spaces = {
			{y = 970.73, z = 235.79, h = 316.56, x = -167.03}
		}
	},
	[39] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 1010.75, z = 235.73, x = -124.76}
		},
		name = 'LX53',
		spaces = {
			{y = 1001.16, z = 234.88, h = 198.68, x = -127.89}
		}
	},
	[40] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 823.95, z = 235.72, x = -101.17}
		},
		name = 'LX54',
		spaces = {
			{y = 832.61, z = 234.86, h = 10.25, x = -105.63}
		}
	},
	[41] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 755.29, z = 204.85, x = 220.71}
		},
		name = 'LX55',
		spaces = {
			{y = 759.38, z = 203.83, h = 47.56, x = 215.84}
		}
	},
	[42] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 563.99, z = 182.94, x = 100.21}
		},
		name = 'LX58',
		spaces = {
			{y = 575.77, z = 182.13, h = 86.85, x = 93.13}
		}
	},
	[43] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 559.77, z = 180.21, x = 52.84}
		},
		name = 'LX59',
		spaces = {
			{y = 563.71, z = 179.54, h = 21.7, x = 53.19}
		}
	},
	[44] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 593.14, z = 203.9, x = -143.65}
		},
		name = 'LX60',
		spaces = {
			{y = 597.23, z = 203.12, h = 358.34, x = -142.21}
		}
	},
	[45] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 621.58, z = 197.91, x = -196.6}
		},
		name = 'LX61',
		spaces = {
			{y = 615.31, z = 196.21, h = 178.98, x = -199.24}
		}
	},
	[46] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 590.04, z = 197.63, x = -174.92}
		},
		name = 'LX62',
		spaces = {
			{y = 587.21, z = 197.03, h = 359.63, x = -178.23}
		}
	},
	[47] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 588.93, z = 190.02, x = -224.87}
		},
		name = 'LX63',
		spaces = {
			{y = 593.25, z = 189.61, h = 331.22, x = -221.77}
		}
	},
	[48] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 599.1, z = 181.68, x = -271.65}
		},
		name = 'LX64',
		spaces = {
			{y = 603.6, z = 181.15, h = 346.6, x = -272.26}
		}
	},
	[49] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 614.9, z = 187.77, x = -241.91}
		},
		name = 'LX65',
		spaces = {
			{y = 610.79, z = 186.09, h = 149.22, x = -244.12}
		}
	},
	[50] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 630.36, z = 172.35, x = -338.28}
		},
		name = 'LX66',
		spaces = {
			{y = 634.83, z = 171.43, h = 52.04, x = -343.97}
		}
	},
	[51] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 566.57, z = 154.53, x = 312.7}
		},
		name = 'LX67',
		spaces = {
			{y = 568.06, z = 153.55, h = 220.69, x = 316.29}
		}
	},
	[52] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 493.62, z = 153.14, x = 315.32}
		},
		name = 'LX68',
		spaces = {
			{y = 494.12, z = 151.61, h = 283.1, x = 321.07}
		}
	},
	[53] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 481.25, z = 151.26, x = 326.54}
		},
		name = 'LX69',
		spaces = {
			{y = 482.12, z = 149.86, h = 195.82, x = 330.37}
		}
	},
	[54] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 526.58, z = 140.58, x = 238.09}
		},
		name = 'LX70',
		spaces = {
			{y = 536.62, z = 139.88, h = 114.71, x = 236.21}
		}
	},
	[55] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -585.69, z = 71.75, x = 1290.05}
		},
		name = 'LS01',
		spaces = {
			{y = -567.62, z = 71.49, h = 344.65, x = 1295.49}
		}
	},
	[56] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -593.07, z = 72.93, x = 1311.03}
		},
		name = 'LS02',
		spaces = {
			{y = -575.18, z = 73.25, h = 336.97, x = 1319.19}
		}
	},
	[57] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -609.86, z = 74.36, x = 1344.65}
		},
		name = 'LS03',
		spaces = {
			{y = -603.76, z = 74.64, h = 334.73, x = 1348.97}
		}
	},
	[58] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -620.48, z = 74.34, x = 1359.91}
		},
		name = 'LS04',
		spaces = {
			{y = -601.83, z = 74.62, h = 359.42, x = 1360.55}
		}
	},
	[59] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -607.72, z = 74.35, x = 1392.87}
		},
		name = 'LS05',
		spaces = {
			{y = -596.21, z = 74.61, h = 52.88, x = 1378.33}
		}
	},
	[60] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -570.68, z = 74.35, x = 1404.84}
		},
		name = 'LS06',
		spaces = {
			{y = -577.37, z = 74.62, h = 113.2, x = 1387.73}
		}
	},
	[61] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -544.46, z = 74.34, x = 1366.95}
		},
		name = 'LS07',
		spaces = {
			{y = -551.94, z = 74.62, h = 157.25, x = 1363.05}
		}
	},
	[62] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -536.8, z = 73.78, x = 1360.66}
		},
		name = 'LS08',
		spaces = {
			{y = -553.3, z = 74.31, h = 156.76, x = 1352.89}
		}
	},
	[63] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -524.9, z = 72.13, x = 1322.0}
		},
		name = 'LS09',
		spaces = {
			{y = -532.96, z = 72.35, h = 160.86, x = 1318.24}
		}
	},
	[64] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -516.59, z = 71.41, x = 1314.79}
		},
		name = 'LS10',
		spaces = {
			{y = -533.58, z = 71.56, h = 160.38, x = 1307.96}
		}
	},
	[65] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -518.7, z = 69.0, x = 1245.08}
		},
		name = 'LS11',
		spaces = {
			{y = -522.7, z = 69.25, h = 257.36, x = 1247.17}
		}
	},
	[66] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -490.29, z = 69.5, x = 1251.25}
		},
		name = 'LS12',
		spaces = {
			{y = -494.22, z = 69.59, h = 255.66, x = 1260.63}
		}
	},
	[67] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -477.81, z = 70.19, x = 1259.55}
		},
		name = 'LS13',
		spaces = {
			{y = -472.81, z = 69.24, h = 170.02, x = 1280.06}
		}
	},
	[68] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -461.81, z = 69.84, x = 1268.56}
		},
		name = 'LS14',
		spaces = {
			{y = -463.9, z = 69.87, h = 328.18, x = 1270.98}
		}
	},
	[69] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -426.7, z = 69.81, x = 1261.12}
		},
		name = 'LS15',
		spaces = {
			{y = -419.35, z = 69.58, h = 297.04, x = 1261.45}
		}
	},
	[70] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -578.25, z = 69.49, x = 1234.75}
		},
		name = 'LS16',
		spaces = {
			{y = -579.36, z = 69.64, h = 271.53, x = 1243.86}
		}
	},
	[71] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -589.55, z = 69.79, x = 1236.79}
		},
		name = 'LS17',
		spaces = {
			{y = -586.85, z = 69.55, h = 269.57, x = 1242.92}
		}
	},
	[72] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -626.17, z = 69.35, x = 1250.47}
		},
		name = 'LS18',
		spaces = {
			{y = -624.91, z = 69.58, h = 296.96, x = 1259.06}
		}
	},
	[73] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -660.38, z = 67.93, x = 1257.67}
		},
		name = 'LS19',
		spaces = {
			{y = -659.12, z = 68.0, h = 293.69, x = 1271.84}
		}
	},
	[74] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -673.65, z = 65.75, x = 1267.25}
		},
		name = 'LS20',
		spaces = {
			{y = -673.42, z = 66.25, h = 277.48, x = 1276.75}
		}
	},
	[75] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -711.08, z = 64.72, x = 1259.79}
		},
		name = 'LS21',
		spaces = {
			{y = -716.66, z = 64.75, h = 239.07, x = 1263.72}
		}
	},
	[76] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -723.04, z = 60.64, x = 1225.19}
		},
		name = 'LS22',
		spaces = {
			{y = -730.21, z = 60.4, h = 163.48, x = 1223.46}
		}
	},
	[77] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -703.47, z = 60.68, x = 1228.5}
		},
		name = 'LS23',
		spaces = {
			{y = -704.09, z = 60.7, h = 97.24, x = 1217.85}
		}
	},
	[78] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -664.18, z = 63.13, x = 1220.91}
		},
		name = 'LS24',
		spaces = {
			{y = -665.12, z = 62.85, h = 103.07, x = 1214.36}
		}
	},
	[79] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -614.0, z = 66.12, x = 1206.75}
		},
		name = 'LS25',
		spaces = {
			{y = -612.47, z = 65.36, h = 94.4, x = 1199.98}
		}
	},
	[80] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -597.08, z = 64.01, x = 1192.48}
		},
		name = 'LS26',
		spaces = {
			{y = -595.06, z = 64.23, h = 34.45, x = 1188.28}
		}
	},
	[81] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -573.78, z = 64.32, x = 1189.79}
		},
		name = 'LS27',
		spaces = {
			{y = -569.96, z = 64.56, h = 25.68, x = 1185.82}
		}
	},
	[82] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -554.97, z = 64.71, x = 1191.61}
		},
		name = 'LS28',
		spaces = {
			{y = -550.38, z = 64.83, h = 86.85, x = 1187.47}
		}
	},
	[83] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -495.42, z = 65.07, x = 1089.59}
		},
		name = 'LS29',
		spaces = {
			{y = -493.34, z = 64.4, h = 79.01, x = 1084.78}
		}
	},
	[84] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -468.42, z = 67.06, x = 1101.7}
		},
		name = 'LS30',
		spaces = {
			{y = -470.87, z = 65.47, h = 77.7, x = 1091.28}
		}
	},
	[85] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -417.0, z = 67.16, x = 1111.03}
		},
		name = 'LS31',
		spaces = {
			{y = -419.57, z = 67.43, h = 83.31, x = 1111.15}
		}
	},
	[86] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -394.29, z = 68.74, x = 1112.77}
		},
		name = 'LS32',
		spaces = {
			{y = -399.24, z = 68.2, h = 78.01, x = 1106.07}
		}
	},
	[87] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -384.09, z = 67.86, x = 1057.42}
		},
		name = 'LS33',
		spaces = {
			{y = -388.45, z = 68.09, h = 221.13, x = 1056.9}
		}
	},
	[88] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -414.33, z = 65.95, x = 1021.13}
		},
		name = 'LS34',
		spaces = {
			{y = -419.52, z = 66.05, h = 219.15, x = 1022.37}
		}
	},
	[89] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -418.88, z = 64.96, x = 1009.82}
		},
		name = 'LS35',
		spaces = {
			{y = -423.87, z = 65.32, h = 217.1, x = 1015.92}
		}
	},
	[90] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -438.07, z = 63.75, x = 987.71}
		},
		name = 'LS36',
		spaces = {
			{y = -435.43, z = 64.23, h = 271.01, x = 995.76}
		}
	},
	[91] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -447.94, z = 62.41, x = 971.53}
		},
		name = 'LS37',
		spaces = {
			{y = -454.41, z = 62.86, h = 213.74, x = 975.54}
		}
	},
	[92] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -463.22, z = 61.26, x = 939.3}
		},
		name = 'LS38',
		spaces = {
			{y = -469.79, z = 61.53, h = 212.33, x = 942.05}
		}
	},
	[93] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -475.65, z = 60.7, x = 928.77}
		},
		name = 'LS39',
		spaces = {
			{y = -480.49, z = 60.88, h = 203.27, x = 933.31}
		}
	},
	[94] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -489.73, z = 59.02, x = 909.42}
		},
		name = 'LS40',
		spaces = {
			{y = -490.17, z = 59.29, h = 204.27, x = 914.46}
		}
	},
	[95] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -503.77, z = 57.5, x = 873.98}
		},
		name = 'LS41',
		spaces = {
			{y = -507.45, z = 57.72, h = 226.29, x = 874.77}
		}
	},
	[96] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -516.17, z = 57.33, x = 854.95}
		},
		name = 'LS42',
		spaces = {
			{y = -522.39, z = 57.59, h = 227.66, x = 858.81}
		}
	},
	[97] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -540.12, z = 57.33, x = 848.57}
		},
		name = 'LS43',
		spaces = {
			{y = -542.76, z = 57.6, h = 266.06, x = 853.51}
		}
	},
	[98] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -567.41, z = 57.71, x = 842.1}
		},
		name = 'LS44',
		spaces = {
			{y = -567.47, z = 57.99, h = 279.71, x = 849.29}
		}
	},
	[99] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -594.02, z = 58.3, x = 868.47}
		},
		name = 'LS45',
		spaces = {
			{y = -590.11, z = 58.28, h = 317.23, x = 872.86}
		}
	},
	[100] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -602.34, z = 58.45, x = 875.58}
		},
		name = 'LS46',
		spaces = {
			{y = -598.36, z = 58.45, h = 316.61, x = 875.55}
		}
	},
	[101] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -631.81, z = 58.05, x = 912.15}
		},
		name = 'LS47',
		spaces = {
			{y = -627.46, z = 58.32, h = 319.36, x = 917.67}
		}
	},
	[102] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -645.12, z = 57.87, x = 913.03}
		},
		name = 'LS48',
		spaces = {
			{y = -639.77, z = 58.14, h = 318.18, x = 917.96}
		}
	},
	[103] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -657.5, z = 58.02, x = 946.14}
		},
		name = 'LS49',
		spaces = {
			{y = -654.13, z = 58.16, h = 309.34, x = 951.67}
		}
	},
	[104] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -672.19, z = 58.02, x = 940.18}
		},
		name = 'LS50',
		spaces = {
			{y = -669.22, z = 58.29, h = 297.96, x = 946.99}
		}
	},
	[105] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -688.32, z = 57.95, x = 969.7}
		},
		name = 'LS51',
		spaces = {
			{y = -685.58, z = 57.91, h = 309.99, x = 973.59}
		}
	},
	[106] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -713.97, z = 57.87, x = 976.24}
		},
		name = 'LS52',
		spaces = {
			{y = -709.42, z = 57.88, h = 312.02, x = 982.5}
		}
	},
	[107] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -734.1, z = 57.46, x = 1004.32}
		},
		name = 'LS53',
		spaces = {
			{y = -731.13, z = 57.88, h = 311.05, x = 1008.02}
		}
	},
	[108] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -614.8, z = 58.84, x = 981.21}
		},
		name = 'LS54',
		spaces = {
			{y = -619.61, z = 59.1, h = 128.1, x = 973.52}
		}
	},
	[109] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -601.7, z = 59.5, x = 959.79}
		},
		name = 'LS55',
		spaces = {
			{y = -598.08, z = 59.65, h = 27.96, x = 955.45}
		}
	},
	[110] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -579.14, z = 59.28, x = 984.25}
		},
		name = 'LS56',
		spaces = {
			{y = -572.6, z = 59.53, h = 31.32, x = 982.93}
		}
	},
	[111] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -565.15, z = 60.2, x = 1008.54}
		},
		name = 'LS57',
		spaces = {
			{y = -563.56, z = 60.44, h = 263.72, x = 1012.51}
		}
	},
	[112] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -243.89, z = 68.63, x = 943.81}
		},
		name = 'LS58',
		spaces = {
			{y = -250.12, z = 68.69, h = 150.37, x = 939.22}
		}
	},
	[113] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -588.12, z = 59.14, x = 1003.79}
		},
		name = 'LS59',
		spaces = {
			{y = -590.25, z = 59.2, h = 258.95, x = 1009.07}
		}
	},
	[114] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -564.06, z = 57.97, x = 922.71}
		},
		name = 'LS60',
		spaces = {
			{y = -567.39, z = 58.24, h = 206.14, x = 926.46}
		}
	},
	[115] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -546.73, z = 59.53, x = 956.87}
		},
		name = 'LS61',
		spaces = {
			{y = -552.49, z = 59.55, h = 211.12, x = 957.91}
		}
	},
	[116] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -530.0, z = 60.12, x = 981.96}
		},
		name = 'LS62',
		spaces = {
			{y = -536.41, z = 60.19, h = 211.11, x = 983.27}
		}
	},
	[117] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -510.47, z = 60.7, x = 1001.36}
		},
		name = 'LS63',
		spaces = {
			{y = -518.48, z = 60.98, h = 205.24, x = 1003.89}
		}
	},
	[118] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -495.92, z = 64.08, x = 1045.95}
		},
		name = 'LS64',
		spaces = {
			{y = -488.79, z = 64.19, h = 257.03, x = 1049.91}
		}
	},
	[119] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -479.89, z = 64.1, x = 1049.12}
		},
		name = 'LS65',
		spaces = {
			{y = -483.32, z = 64.11, h = 257.85, x = 1056.64}
		}
	},
	[120] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -445.56, z = 65.97, x = 1055.36}
		},
		name = 'LS66',
		spaces = {
			{y = -445.67, z = 66.16, h = 257.58, x = 1062.56}
		}
	},
	[121] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -464.4, z = 63.9, x = 1020.06}
		},
		name = 'LS67',
		spaces = {
			{y = -459.29, z = 64.37, h = 38.05, x = 1019.04}
		}
	},
	[122] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -505.37, z = 61.74, x = 966.19}
		},
		name = 'LS68',
		spaces = {
			{y = -500.52, z = 61.65, h = 29.8, x = 960.86}
		}
	},
	[123] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -516.97, z = 60.25, x = 950.42}
		},
		name = 'LS69',
		spaces = {
			{y = -511.66, z = 60.5, h = 29.22, x = 948.5}
		}
	},
	[124] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -527.47, z = 59.58, x = 921.11}
		},
		name = 'LS70',
		spaces = {
			{y = -522.63, z = 59.03, h = 25.35, x = 915.83}
		}
	},
	[125] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -547.44, z = 58.17, x = 893.88}
		},
		name = 'LS71',
		spaces = {
			{y = -551.92, z = 58.24, h = 115.0, x = 888.36}
		}
	},
	[126] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -429.62, z = 67.4, x = 1103.28}
		},
		name = 'LS72',
		spaces = {
			{y = -428.24, z = 66.68, h = 80.97, x = 1097.86}
		}
	},
	[127] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 2190.1, z = 78.85, x = 1551.96}
		},
		name = 'SS01',
		spaces = {
			{y = 2196.07, z = 78.5, h = 352.11, x = 1554.26}
		}
	},
	[128] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -572.99, z = 11.82, x = -1890.29}
		},
		name = 'MS09',
		spaces = {
			{y = -571.43, z = 10.93, h = 319.54, x = -1886.63}
		}
	},
	[129] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 463.46, z = 88.22, x = -864.47}
		},
		name = 'FH01',
		spaces = {
			{y = 462.66, z = 86.93, h = 276.73, x = -861.31}
		}
	},
	[130] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 655.82, z = 25.8, x = -2977.53}
		},
		name = 'MS08',
		spaces = {
			{y = 655.9, z = 24.43, h = 104.93, x = -2982.99}
		}
	},
	[131] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 688.21, z = 25.48, x = -2996.32}
		},
		name = 'MS07',
		spaces = {
			{y = 690.09, z = 23.7, h = 109.64, x = -3002.79}
		}
	},
	[132] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 522.18, z = 90.62, x = -850.62}
		},
		name = 'FH04',
		spaces = {
			{y = 514.29, z = 90.15, h = 106.56, x = -851.05}
		}
	},
	[133] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 740.75, z = 27.58, x = -3014.84}
		},
		name = 'MS05',
		spaces = {
			{y = 740.24, z = 26.63, h = 103.34, x = -3019.92}
		}
	},
	[134] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 1927.04, z = 167.31, x = -2596.87}
		},
		name = 'MS04',
		spaces = {
			{y = 1929.85, z = 166.46, h = 275.01, x = -2588.73}
		}
	},
	[135] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 901.64, z = 230.57, x = -681.48}
		},
		name = 'MS03',
		spaces = {
			{y = 903.59, z = 229.73, h = 326.35, x = -675.44}
		}
	},
	[136] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 551.97, z = 95.62, x = -912.38}
		},
		name = 'FH08',
		spaces = {
			{y = 553.88, z = 96.49, h = 311.55, x = -907.51}
		}
	},
	[137] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 184.23, z = 72.47, x = -813.06}
		},
		name = 'MS02',
		spaces = {
			{y = 185.31, z = 71.25, h = 119.13, x = -821.16}
		}
	},
	[138] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 548.3, z = 176.02, x = 21.41}
		},
		name = 'MS01',
		spaces = {
			{y = 549.89, z = 175.5, h = 60.7, x = 14.98}
		}
	},
	[139] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 445.34, z = 80.42, x = -938.56}
		},
		name = 'FH11',
		spaces = {
			{y = 443.81, z = 79.99, h = 198.88, x = -942.71}
		}
	},
	[140] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6644.04, z = 31.93, x = 81.27}
		},
		name = 'PB31',
		spaces = {
			{y = 6635.25, z = 31.75, h = 142.72, x = 72.41}
		}
	},
	[141] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6659.22, z = 31.65, x = 24.79}
		},
		name = 'PB30',
		spaces = {
			{y = 6661.48, z = 31.44, h = 182.65, x = 21.16}
		}
	},
	[142] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6601.97, z = 32.48, x = 25.06}
		},
		name = 'PB29',
		spaces = {
			{y = 6606.74, z = 32.38, h = 267.62, x = 36.23}
		}
	},
	[143] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 468.75, z = 77.82, x = -1074.27}
		},
		name = 'FH15',
		spaces = {
			{y = 465.49, z = 76.79, h = 144.79, x = -1079.1}
		}
	},
	[144] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1872.65, z = 26.25, x = 396.69}
		},
		name = 'LV25',
		spaces = {
			{y = -1877.44, z = 26.35, h = 222.91, x = 397.28}
		}
	},
	[145] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1894.9, z = 24.99, x = 360.06}
		},
		name = 'LV27',
		spaces = {
			{y = -1896.77, z = 25.08, h = 227.0, x = 357.8}
		}
	},
	[146] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1937.5, z = 24.82, x = 315.73}
		},
		name = 'LV28',
		spaces = {
			{y = -1942.05, z = 24.92, h = 230.52, x = 315.5}
		}
	},
	[147] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 455.98, z = 79.82, x = -971.31}
		},
		name = 'FH19',
		spaces = {
			{y = 450.03, z = 78.97, h = 199.58, x = -967.03}
		}
	},
	[148] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1965.91, z = 23.74, x = 310.66}
		},
		name = 'LV29',
		spaces = {
			{y = -1970.62, z = 23.69, h = 138.57, x = 316.82}
		}
	},
	[149] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1980.29, z = 21.4, x = 282.89}
		},
		name = 'LV31',
		spaces = {
			{y = -1985.85, z = 21.41, h = 229.16, x = 285.64}
		}
	},
	[150] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1991.24, z = 20.46, x = 280.83}
		},
		name = 'LV32',
		spaces = {
			{y = -1992.54, z = 20.81, h = 228.61, x = 286.37}
		}
	},
	[151] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 439.85, z = 106.9, x = -736.59}
		},
		name = 'FH23',
		spaces = {
			{y = 446.59, z = 105.88, h = 3.21, x = -736.19}
		}
	},
	[152] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 500.53, z = 109.27, x = -716.59}
		},
		name = 'FH24',
		spaces = {
			{y = 495.36, z = 108.43, h = 206.78, x = -716.94}
		}
	},
	[153] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6265.04, z = 31.53, x = -360.84}
		},
		name = 'PB06',
		spaces = {
			{y = 6265.07, z = 31.32, h = 46.14, x = -352.17}
		}
	},
	[154] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 507.84, z = 110.36, x = -692.91}
		},
		name = 'FH26',
		spaces = {
			{y = 500.77, z = 109.21, h = 201.51, x = -688.85}
		}
	},
	[155] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6412.01, z = 31.92, x = -187.33}
		},
		name = 'PB19',
		spaces = {
			{y = 6418.12, z = 31.78, h = 44.99, x = -187.43}
		}
	},
	[156] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1936.94, z = 24.35, x = 248.94}
		},
		name = 'LV01',
		spaces = {
			{y = -1927.99, z = 24.39, h = 319.7, x = 240.16}
		}
	},
	[157] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 492.54, z = 106.97, x = -574.21}
		},
		name = 'FH29',
		spaces = {
			{y = 498.15, z = 105.38, h = 9.46, x = -573.79}
		}
	},
	[158] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1914.8, z = 25.81, x = 270.61}
		},
		name = 'LV03',
		spaces = {
			{y = -1905.53, z = 26.78, h = 51.02, x = 270.12}
		}
	},
	[159] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 531.83, z = 108.17, x = -589.59}
		},
		name = 'FH31',
		spaces = {
			{y = 526.68, z = 106.72, h = 215.41, x = -586.67}
		}
	},
	[160] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 394.76, z = 100.67, x = -574.01}
		},
		name = 'FH32',
		spaces = {
			{y = 401.65, z = 99.82, h = 19.61, x = -574.73}
		}
	},
	[161] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1849.98, z = 27.77, x = 340.81}
		},
		name = 'LV06',
		spaces = {
			{y = -1835.98, z = 27.61, h = 44.87, x = 335.81}
		}
	},
	[162] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1828.31, z = 27.95, x = 344.21}
		},
		name = 'LV07',
		spaces = {
			{y = -1817.23, z = 27.99, h = 320.18, x = 333.16}
		}
	},
	[163] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1811.51, z = 28.8, x = 350.15}
		},
		name = 'LV08',
		spaces = {
			{y = -1806.23, z = 28.48, h = 319.97, x = 342.37}
		}
	},
	[164] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1753.91, z = 29.37, x = 404.54}
		},
		name = 'LV09',
		spaces = {
			{y = -1739.39, z = 29.54, h = 46.7, x = 403.61}
		}
	},
	[165] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1741.22, z = 29.61, x = 430.66}
		},
		name = 'LV10',
		spaces = {
			{y = -1735.54, z = 28.65, h = 50.2, x = 431.33}
		}
	},
	[166] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1715.43, z = 29.33, x = 434.96}
		},
		name = 'LV11',
		spaces = {
			{y = -1715.87, z = 28.69, h = 49.34, x = 430.06}
		}
	},
	[167] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1698.41, z = 29.38, x = 442.86}
		},
		name = 'LV12',
		spaces = {
			{y = -1693.12, z = 28.66, h = 51.33, x = 442.78}
		}
	},
	[168] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1698.89, z = 29.41, x = 498.38}
		},
		name = 'LV13',
		spaces = {
			{y = -1702.77, z = 29.64, h = 236.28, x = 498.01}
		}
	},
	[169] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1718.03, z = 29.37, x = 479.02}
		},
		name = 'LV14',
		spaces = {
			{y = -1721.93, z = 29.62, h = 251.19, x = 490.02}
		}
	},
	[170] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1740.78, z = 29.11, x = 464.62}
		},
		name = 'LV15',
		spaces = {
			{y = -1744.08, z = 29.21, h = 250.4, x = 473.8}
		}
	},
	[171] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1755.13, z = 28.76, x = 475.52}
		},
		name = 'LV16',
		spaces = {
			{y = -1757.75, z = 28.71, h = 163.16, x = 488.5}
		}
	},
	[172] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1772.84, z = 28.7, x = 475.02}
		},
		name = 'LV17',
		spaces = {
			{y = -1779.06, z = 28.93, h = 270.19, x = 478.21}
		}
	},
	[173] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 376.54, z = 104.77, x = -447.07}
		},
		name = 'FH45',
		spaces = {
			{y = 372.48, z = 103.93, h = 358.58, x = -456.49}
		}
	},
	[174] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1799.04, z = 28.49, x = 504.82}
		},
		name = 'LV19',
		spaces = {
			{y = -1792.86, z = 28.65, h = 161.09, x = 500.19}
		}
	},
	[175] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1808.65, z = 28.51, x = 504.77}
		},
		name = 'LV20',
		spaces = {
			{y = -1805.02, z = 28.65, h = 138.92, x = 491.87}
		}
	},
	[176] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 525.26, z = 112.44, x = -523.67}
		},
		name = 'FH48',
		spaces = {
			{y = 530.68, z = 110.95, h = 44.11, x = -526.66}
		}
	},
	[177] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 573.16, z = 121.24, x = -524.63}
		},
		name = 'FH49',
		spaces = {
			{y = 574.05, z = 120.61, h = 281.57, x = -519.47}
		}
	},
	[178] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1839.65, z = 28.08, x = 428.72}
		},
		name = 'LV23',
		spaces = {
			{y = -1841.14, z = 28.23, h = 222.18, x = 434.57}
		}
	},
	[179] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1844.77, z = 26.84, x = 395.08}
		},
		name = 'LV24',
		spaces = {
			{y = -1850.26, z = 26.2, h = 223.86, x = 395.69}
		}
	},
	[180] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 538.11, z = 121.46, x = -470.24}
		},
		name = 'FH52',
		spaces = {
			{y = 542.62, z = 119.92, h = 355.06, x = -468.04}
		}
	},
	[181] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1890.77, z = 25.32, x = 385.03}
		},
		name = 'LV26',
		spaces = {
			{y = -1896.36, z = 25.21, h = 222.83, x = 384.63}
		}
	},
	[182] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 512.34, z = 120.19, x = -397.25}
		},
		name = 'FH54',
		spaces = {
			{y = 518.94, z = 119.68, h = 355.21, x = -398.63}
		}
	},
	[183] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 473.56, z = 112.52, x = -356.43}
		},
		name = 'FH55',
		spaces = {
			{y = 474.7, z = 111.89, h = 299.59, x = -351.33}
		}
	},
	[184] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 566.28, z = 124.62, x = -404.09}
		},
		name = 'FH56',
		spaces = {
			{y = 559.97, z = 123.79, h = 152.09, x = -409.68}
		}
	},
	[185] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1971.96, z = 22.49, x = 299.42}
		},
		name = 'LV30',
		spaces = {
			{y = -1982.39, z = 22.39, h = 139.63, x = 306.82}
		}
	},
	[186] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 517.38, z = 120.15, x = -357.14}
		},
		name = 'FH58',
		spaces = {
			{y = 514.72, z = 118.67, h = 134.89, x = -362.62}
		}
	},
	[187] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 483.18, z = 113.46, x = -312.45}
		},
		name = 'FH59',
		spaces = {
			{y = 480.85, z = 111.44, h = 118.55, x = -320.42}
		}
	},
	[188] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -2026.71, z = 18.86, x = 256.42}
		},
		name = 'LV33',
		spaces = {
			{y = -2029.38, z = 18.82, h = 142.23, x = 267.58}
		}
	},
	[189] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -2021.42, z = 18.71, x = 240.68}
		},
		name = 'LV34',
		spaces = {
			{y = -2035.94, z = 18.53, h = 228.9, x = 246.74}
		}
	},
	[190] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -2042.78, z = 18.02, x = 241.9}
		},
		name = 'LV35',
		spaces = {
			{y = -2053.88, z = 18.1, h = 134.18, x = 245.74}
		}
	},
	[191] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6202.62, z = 29.56, x = -442.95}
		},
		name = 'PB01',
		spaces = {
			{y = 6206.42, z = 29.57, h = 278.13, x = -435.4}
		}
	},
	[192] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6187.37, z = 31.54, x = -375.5}
		},
		name = 'PB02',
		spaces = {
			{y = 6184.85, z = 31.4, h = 223.82, x = -379.5}
		}
	},
	[193] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6204.76, z = 31.58, x = -361.91}
		},
		name = 'PB03',
		spaces = {
			{y = 6200.05, z = 31.4, h = 224.98, x = -367.92}
		}
	},
	[194] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6227.29, z = 31.5, x = -359.1}
		},
		name = 'PB04',
		spaces = {
			{y = 6217.17, z = 31.4, h = 223.88, x = -349.5}
		}
	},
	[195] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6254.9, z = 31.49, x = -381.48}
		},
		name = 'PB05',
		spaces = {
			{y = 6273.42, z = 30.02, h = 50.83, x = -388.73}
		}
	},
	[196] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 451.89, z = 105.34, x = -1371.63}
		},
		name = 'FH68',
		spaces = {
			{y = 453.26, z = 104.04, h = 80.28, x = -1376.73}
		}
	},
	[197] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6264.1, z = 30.09, x = -436.46}
		},
		name = 'PB07',
		spaces = {
			{y = 6260.87, z = 30.31, h = 258.67, x = -429.99}
		}
	},
	[198] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6317.15, z = 28.95, x = -402.95}
		},
		name = 'PB08',
		spaces = {
			{y = 6311.99, z = 28.84, h = 220.7, x = -396.68}
		}
	},
	[199] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6337.74, z = 29.85, x = -364.3}
		},
		name = 'PB09',
		spaces = {
			{y = 6328.54, z = 29.75, h = 220.61, x = -360.16}
		}
	},
	[200] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6310.94, z = 32.48, x = -311.14}
		},
		name = 'PB10',
		spaces = {
			{y = 6317.76, z = 31.77, h = 45.39, x = -318.17}
		}
	},
	[201] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6335.9, z = 32.49, x = -291.83}
		},
		name = 'PB11',
		spaces = {
			{y = 6340.57, z = 31.82, h = 46.26, x = -296.49}
		}
	},
	[202] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6353.73, z = 32.49, x = -272.11}
		},
		name = 'PB12',
		spaces = {
			{y = 6355.22, z = 32.4, h = 47.15, x = -267.41}
		}
	},
	[203] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6355.12, z = 31.5, x = -250.27}
		},
		name = 'PB13',
		spaces = {
			{y = 6360.48, z = 31.39, h = 45.08, x = -255.08}
		}
	},
	[204] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6408.91, z = 31.12, x = -271.22}
		},
		name = 'PB14',
		spaces = {
			{y = 6406.49, z = 30.88, h = 210.49, x = -265.26}
		}
	},
	[205] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6374.6, z = 31.68, x = -217.34}
		},
		name = 'PB15',
		spaces = {
			{y = 6383.16, z = 31.52, h = 45.87, x = -219.54}
		}
	},
	[206] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6423.56, z = 31.46, x = -238.3}
		},
		name = 'PB16',
		spaces = {
			{y = 6420.27, z = 31.16, h = 220.84, x = -233.04}
		}
	},
	[207] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6396.75, z = 31.87, x = -201.42}
		},
		name = 'PB17',
		spaces = {
			{y = 6401.82, z = 31.77, h = 46.62, x = -201.53}
		}
	},
	[208] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6445.5, z = 31.2, x = -229.57}
		},
		name = 'PB18',
		spaces = {
			{y = 6435.29, z = 31.11, h = 22964, x = -224.33}
		}
	},
	[209] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 676.11, z = 148.54, x = -463.57}
		},
		name = 'FH81',
		spaces = {
			{y = 673.46, z = 146.8, h = 148.4, x = -467.37}
		}
	},
	[210] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6561.7, z = 29.53, x = -122.88}
		},
		name = 'PB20',
		spaces = {
			{y = 6567.64, z = 29.43, h = 224.24, x = -115.59}
		}
	},
	[211] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6531.68, z = 29.81, x = -101.69}
		},
		name = 'PB21',
		spaces = {
			{y = 6536.09, z = 29.72, h = 45.2, x = -106.48}
		}
	},
	[212] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6578.82, z = 32.35, x = -37.32}
		},
		name = 'PB22',
		spaces = {
			{y = 6593.44, z = 30.34, h = 37.22, x = -40.97}
		}
	},
	[213] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6566.75, z = 31.91, x = -15.06}
		},
		name = 'PB23',
		spaces = {
			{y = 6561.16, z = 31.88, h = 224.22, x = -8.44}
		}
	},
	[214] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6578.36, z = 33.08, x = 11.48}
		},
		name = 'PB24',
		spaces = {
			{y = 6583.02, z = 32.35, h = 223.198, x = 15.78}
		}
	},
	[215] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6598.51, z = 31.48, x = -17.04}
		},
		name = 'PB25',
		spaces = {
			{y = 6598.24, z = 31.38, h = 39.88, x = -8.5}
		}
	},
	[216] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6634.26, z = 30.23, x = -43.93}
		},
		name = 'PB26',
		spaces = {
			{y = 6623.94, z = 29.87, h = 221, x = -52.4}
		}
	},
	[217] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6650.52, z = 31.15, x = -14.79}
		},
		name = 'PB27',
		spaces = {
			{y = 6645.42, z = 31.03, h = 208.0, x = -15.82}
		}
	},
	[218] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 6618.26, z = 31.47, x = 2.37}
		},
		name = 'PB28',
		spaces = {
			{y = 6618.68, z = 31.34, h = 60.09, x = -5.0}
		}
	},
	[219] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 804.188, z = 177.56, x = -956.88}
		},
		name = 'FH91',
		spaces = {
			{y = 800.59, z = 176.76, h = 152.94, x = -958.62}
		}
	},
	[220] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 813.8, z = 184.33, x = -921.15}
		},
		name = 'FH92',
		spaces = {
			{y = 806.38, z = 183.37, h = 189.06, x = -920.0}
		}
	},
	[221] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 783.99, z = 171.38, x = -1004.0}
		},
		name = 'FH93',
		spaces = {
			{y = 786.76, z = 171.06, h = 293.5, x = -997.95}
		}
	},
	[222] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 803.55, z = 202.18, x = -810.25}
		},
		name = 'FH94',
		spaces = {
			{y = 809.51, z = 201.24, h = 19.71, x = -811.6}
		}
	},
	[223] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1828.9, z = 28.18, x = 431.96}
		},
		name = 'LV22',
		spaces = {
			{y = -1837.91, z = 28.21, h = 223.26, x = 437.06}
		}
	},
	[224] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1826.73, z = 28.53, x = 487.7}
		},
		name = 'LV21',
		spaces = {
			{y = -1819.72, z = 28.1, h = 139.7, x = 479.28}
		}
	},
	[225] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1778.19, z = 28.51, x = 511.46}
		},
		name = 'LV18',
		spaces = {
			{y = -1777.14, z = 28.64, h = 201.67, x = 499.79}
		}
	},
	[226] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1856.29, z = 27.11, x = 318.07}
		},
		name = 'LV05',
		spaces = {
			{y = -1850.27, z = 27.0, h = 320.21, x = 305.2}
		}
	},
	[227] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1899.45, z = 26.89, x = 279.17}
		},
		name = 'LV04',
		spaces = {
			{y = -1892.82, z = 26.83, h = 319.63, x = 269.73}
		}
	},
	[228] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -1932.86, z = 25.44, x = 269.8}
		},
		name = 'LV02',
		spaces = {
			{y = -1925.64, z = 25.52, h = 47.52, x = 267.71}
		}
	},
	[229] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -57.11, z = 38.05, x = -876.54}
		},
		name = 'LX01',
		spaces = {
			{y = -54.25, z = 37.6, h = 281.38, x = -869.45}
		}
	},
	[230] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = -17.35, z = 43.1, x = -890.55}
		},
		name = 'LX02',
		spaces = {
			{y = -16.18, z = 42.15, h = 304.12, x = -885.98}
		}
	},
	[231] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 51.35, z = 48.78, x = -872.28}
		},
		name = 'LX03',
		spaces = {
			{y = 46.86, z = 48.39, h = 195.46, x = -875.02}
		}
	},
	[232] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 107.74, z = 55.66, x = -969.08}
		},
		name = 'LX04',
		spaces = {
			{y = 109.36, z = 55.49, h = 314.26, x = -960.77}
		}
	},
	[233] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 629.92, z = 129.99, x = -1885.63}
		},
		name = 'LX05',
		spaces = {
			{y = 626.0, z = 129.15, h = 136.16, x = -1890.51}
		}
	},
	[234] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 142.37, z = 60.66, x = -997.43}
		},
		name = 'LX06',
		spaces = {
			{y = 144.19, z = 59.81, h = 269.99, x = -992.02}
		}
	},
	[235] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 224.98, z = 63.76, x = -1045.16}
		},
		name = 'LX07',
		spaces = {
			{y = 219.47, z = 62.91, h = 184.73, x = -1048.01}
		}
	},
	[236] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 212.7, z = 67.46, x = -923.9}
		},
		name = 'LX08',
		spaces = {
			{y = 210.69, z = 66.61, h = 163.52, x = -933.57}
		}
	},
	[237] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 196.27, z = 69.5, x = -905.04}
		},
		name = 'LX09',
		spaces = {
			{y = 190.68, z = 68.59, h = 179.92, x = -911.78}
		}
	},
	[238] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 114.68, z = 55.31, x = -915.48}
		},
		name = 'LX10',
		spaces = {
			{y = 112.49, z = 54.47, h = 84.9, x = -920.41}
		}
	},
	[239] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},
		point = {
			{y = 13.37, z = 47.91, x = -931.72}
		},
		name = 'LX11',
		spaces = {
			{y = 9.31, z = 46.87, h = 214.83, x = -925.27}
		}
	},
	[240] = {
		marker = 36,
		blip = {scale = 0.4, color = 4, type = 357},   -- -533.99,482.88,103.18
		point = {
			{y = -533.99, z = 482.88, x = 103.18}
		},
		name = 'FH47',
		spaces = {
			{y = 488.7, z = 103.25, h = 50.14, x = -539.37}    -- -539.37,488.7,103.25
		}
	}
}