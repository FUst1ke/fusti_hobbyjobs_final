Config = {}
Config.Debug = false
Config.InteractDistance = 3.0

Config.Notifies = {
    ['itemSellMenu'] = {
        header = 'Sell your items',
        label = 'Choose what do you want to sell',
        description = 'List:'
    },
    ['no_select'] = {
        title = 'Information',
        description = 'Something is wrong!',
        type = 'error',
        icon = 'fa-car'
    },
    ['no_money'] = {
        title = 'Information',
        description = 'You do not have any money!',
        type = 'error',
        icon = 'fa-money-bill'
    },
    ['spawnpoint_not_clear'] = {
        title = 'Information',
        description = 'Something is blocking the spawnpoint!',
        type = 'error',
        icon = 'fa-car'
    },
    ['success_spawn'] = {
        title = 'Information',
        description = 'You have successfully spawned the vehicle!',
        type = 'success',
        icon = 'fa-car'
    },
    ['no_more_task'] = {
        title = 'Information',
        description = 'You have already done your tasks!',
        type = 'inform',
        icon = 'fa-check'
    },
    ['task_to_go'] = {
        title = 'Information',
        description = 'You have finished your work here, there are %s more to go!',
        type = 'success',
        icon = 'fa-check'
    },
    ['success_sold'] = {
        title = 'Information',
        description = 'You have successfully sold %sx %s for: %s$',
        type = 'success',
        icon = 'fa-money-bill'
    },
    ['no_item'] = {
        title = 'Information',
        description = 'You do not have any %s on you!',
        type = 'error',
        icon = 'fa-money-bill'
    },
    ['skillCheck_failed'] = {
        title = 'Information',
        description = 'Failed!',
        type = 'error',
        icon = 'fa-check'
    },
    ['everything_is_done'] = {
        header = 'Information',
        content = 'You have done every task, go back to the boss.',
        centered = true,
        cancel = false
    },
    ['no_requiedItem'] = {
        title = 'Information',
        description = 'You do not have any %s on you!',
        type = 'error',
        icon = 'fa-check'
    },
    ['context'] = '[E] to open the menu',
}

Config.Zones = {
    ['apple_picking'] = {
        ['mainPlace'] = {
            ped = {
                model = `a_m_m_afriamer_01`,
                coord = vec3(2301.6726, 4755.1230, 36.2161),
                heading = 257.0
            },
            blip = {
                sprite = 351,
                display = 4,
                scale = 1.2,
                colour = 2,
                text = 'Apple picking job'
            }
        },
        ['vehicles'] = {
            plate = 'WORK',
            spawnCoord = {
                position = vec3(2309.8376, 4758.4790, 37.16), 
                heading = 256.5729, 
                radius = 3.0
            },
            list = {
                {label = 'Burrito', value = 'burrito3', sellPrice = 100}
            }
        },
        ['actions'] = {
            type = 'box', -- sphere or box
            boxData = {
                coord = vec3(2414.6523, 4688.2646, 33.5066), 
                size = vec3(70,120,100),
                rotation = 45
            },
            blip = {
                sprite = 677,
                display = 4,
                scale = 0.5,
                colour = 2,
                text = 'Apple picking',
                radius = {
                    colour = 2,
                    alpha = 70
                }
            },
            coords = { -- position must be in the zone!
                {position = vec3(2402.4517, 4688.7593, 33.6607), heading = 100.0},
                {position = vec3(2390.4346, 4691.1538, 33.9041), heading = 100.0},
                {position = vec3(2381.8682, 4701.3037, 33.9474), heading = 100.0},
                {position = vec3(2383.6780, 4713.3687, 33.6394), heading = 100.0}
            },
            action = {
                requiredItem = 'water', -- none or item name

                context = 'Press [E] to start picking apple',

                skillCheckData = { -- false or data
                    difficulty = {'easy', 'easy', 'easy', 'easy'},
                    inputs = {'w', 'a', 's', 'd'}
                },

                TaskBlipData = { -- false or data
                    sprite = 1,
                    display = 2,
                    scale = 1.0,
                    colour = 0,
                    text = 'Apple tree',
                },

                prop = nil, -- nil or prop name

                anim = {
                    dict = 'amb@prop_human_movie_bulb@idle_a',
                    name = 'idle_a'
                },

                progbar = {
                    time = 5000,
                    label = 'Picking apple..',
                    attach = {
                        prop = nil, -- nil or prop name
                        bone = 57005,
                        pos = vec3(0.1, 0.0, 0.0),
                        rot = vec3(-90.0, 25.0, 35.0)
                    }
                },
            },
            items = {
                {value = 'burger',  label = 'Burger',  count = 1, chance = 9, sellPrice = 10},
                {value = 'garbage', label = 'Garbage', count = 1, chance = 9, sellPrice = 50},
                {value = 'water',   label = 'Water',   count = 1, chance = 9, sellPrice = 85} 
            }
        }
    },
    ['mining'] = {
        ['mainPlace'] = {
            ped = {
                model = `s_m_y_construct_01`,
                coord = vec3(2569.2310, 2720.3987, 41.9649),
                heading = 212.2913
            },
            blip = {
                sprite = 351,
                display = 4,
                scale = 1.2,
                colour = 5,
                text = 'Bánya'
            }
        },
        ['vehicles'] = {
            plate = 'MINER',
            spawnCoord = {
                position = vec3(2586.4351, 2713.2129, 42.9112), 
                heading = 297.0, 
                radius = 3.0
            },
            list = {
                {label = 'Rebel',     value = 'rebel',     sellPrice = 50},
                {label = 'Sandking',  value = 'sandking',  sellPrice = 75},
            }
        },
        ['actions'] = {
            type = 'sphere', -- sphere or box
            sphereData = {
                coord = vec3(2946.9448, 2794.2903, 40.6426),
                radius = 160.0
            },
            blip = {
                sprite = 587,
                display = 4,
                scale = 0.5,
                colour = 5,
                text = 'Mine',
                radius = {
                    colour = 5,
                    alpha = 100
                }
            },
            coords = { -- position must be in the zone!
                {position = vec3(2952.7761, 2803.1016, 40.6748), heading = 100.0},
                {position = vec3(2961.16, 2790.8372, 39.4044), heading = 100.0},
                {position = vec3(2949.5229, 2776.6389, 38.2646), heading = 100.0},
                {position = vec3(2930.6895, 2795.6553, 39.7646), heading = 100.0},
                {position = vec3(2962.4783, 2856.1558, 57.4530 - 1), heading = 200.6233},
                {position = vec3(2938.1255, 2852.5891, 56.9333 - 1), heading = 111.3778},
                {position = vec3(2912.2505, 2838.6326, 54.8319 - 1), heading = 165.4709},
                {position = vec3(2902.9358, 2820.8926, 53.9393 - 1), heading = 173.0546},
                {position = vec3(2906.7520, 2807.3923, 54.2330 - 1), heading = 192.1493},
                {position = vec3(2885.7776, 2787.1807, 56.3966 - 1), heading = 95.08800},
                {position = vec3(2905.1936, 2774.9504, 54.0707 - 1), heading = 250.9146},
                {position = vec3(2906.3328, 2760.0249, 53.5639 - 1), heading = 343.8593},
                {position = vec3(2922.5044, 2755.9385, 53.6698 - 1), heading = 261.7463},
                {position = vec3(2944.5488, 2721.9658, 53.8365 - 1), heading = 232.7725},
                {position = vec3(2958.5435, 2674.3467, 64.0112 - 1), heading = 34.3147},
                {position = vec3(2964.3723, 2676.4124, 64.2934 - 1), heading = 9.2332},
            },
            action = {
                requiredItem = 'water', -- none or item name

                context = 'Press [E] to start mining',

                skillCheckData = { -- if skill check is true
                    difficulty = {'easy', 'easy', 'easy', 'easy'},
                    inputs = {'w', 'a', 's', 'd'}
                },

                TaskBlipData = {
                    sprite = 1,
                    display = 2,
                    scale = 1.0,
                    colour = 0,
                    text = 'Ore',
                },

                prop = `prop_rock_3_d`,

                anim = {
                    dict = 'melee@hatchet@streamed_core_fps',
                    name = 'plyr_front_takedown'
                },

                progbar = {
                    time = 5000,
                    label = 'Mining ore..',
                    attach = {
                        prop = `prop_tool_pickaxe`,
                        bone = 57005,
                        pos = vec3(0.1, 0.0, 0.0),
                        rot = vec3(-90.0, 25.0, 35.0)
                    }
                },
            },
            items = {
                {value = 'iron',  label = 'Vas',  count = 1, chance = 5, sellPrice = 10},
                {value = 'metal', label = 'Fém', count = 1, chance = 7, sellPrice = 50},
                {value = 'gold',   label = 'Arany',   count = 1, chance = 3, sellPrice = 85},
                {value = 'diamond', label = 'Gyémánt', count = 1, chance = 2, sellPrice = 100} 
            }
        }
    },
    ['scuba'] = {
        ['mainPlace'] = {
            ped = {
                model = `a_m_y_surfer_01`,
                coord = vec3(-1593.1282, 5203.0127, 3.3101),
                heading = 295.0130
            },
            blip = {
                sprite = 351,
                display = 4,
                scale = 1.2,
                colour = 68,
                text = 'Búvárkodás'
            }
        },
        ['vehicles'] = {
            plate = 'SCUBA',
            spawnCoord = {
                position = vec3(-1603.0309, 5259.3589, -0.4746), 
                heading = 20.1646, 
                radius = 3.0
            },
            list = {
                {label = 'SeaShark',     value = 'seashark',     sellPrice = 50}
            }
        },
        ['actions'] = {
            type = 'sphere', -- sphere or box
            sphereData = {
                coord = vec3(-901.9572, 6647.7842, -17.4694),
                radius = 200.0
            },
            blip = {
                sprite = 729,
                display = 4,
                scale = 1.2,
                colour = 68,
                text = 'Búvár zóna',
                radius = {
                    colour = 68,
                    alpha = 100
                }
            },
            coords = { -- position must be in the zone!
                {position = vec3(-876.7582, 6635.0381, -32.3243), heading = 230.0},
                {position = vec3(-840.1068, 6636.2734, -25.7403), heading = 17.5464},
                {position = vec3(-808.5626, 6664.3521, -13.1792), heading = 62.5774},
                {position = vec3(-845.5273, 6665.5449, -26.4233), heading = 349.4162},
                {position = vec3(-977.5391, 6686.3794, -39.5615), heading = 73.4118},
                {position = vec3(-881.9871, 6625.8892, -33.3231), heading = 215.8322},
                {position = vec3(-875.6296, 6631.3950, -32.6453), heading = 301.6638},
                {position = vec3(-883.7550, 6599.1294, -33.0495), heading = 322.8471},
                {position = vec3(-894.3299, 6612.3979, -32.4721), heading = 199.6495},
                {position = vec3(-890.6596, 6592.8496, -31.9627), heading = 170.9557},
                {position = vec3(-884.8878, 6590.8853, -31.6074), heading = 330.2878},
                {position = vec3(-847.9102, 6581.7725, -30.3285), heading = 135.3363},
                {position = vec3(-857.4401, 6567.6587, -30.3454), heading = 3.5694},
                {position = vec3(-844.4438, 6578.1948, -29.9691), heading = 285.7452},
                {position = vec3(-865.0121, 6587.0117, -31.9325), heading = 68.2921},
                {position = vec3(-883.7534, 6595.0972, -32.8032), heading = 62.5324}
            },
            action = {
                requiredItem = 'water', -- none or item name

                context = 'Nyomj [E] -t a hegesztéshez',

                skillCheckData = { -- if skill check is true
                    difficulty = {'easy', 'easy', 'easy', 'easy'},
                    inputs = {'w', 'a', 's', 'd'}
                },

                TaskBlipData = {
                    sprite = 1,
                    display = 2,
                    scale = 1.0,
                    colour = 0,
                    text = 'Láda',
                },

                prop = `xm_prop_x17_chest_closed`,

                anim = {
                    dict = 'amb@world_human_welding@male@base',
                    name = 'base'
                },

                progbar = {
                    time = 5000,
                    label = 'Opening chest..',
                    attach = {
                        prop = 'prop_weld_torch',
                        bone = 28422,
                        pos = vec3(0.0, 0.0, 0.0),
                        rot = vec3(0.0, 0.0, 0.0)
                    }
                },
            },
            items = {
                {value = 'gold_chain',  label = 'Arany lánc',  count = 1, chance = 2, sellPrice = 10},
                {value = 'gold_watch', label = 'Arany óra', count = 1, chance = 2, sellPrice = 50},
                {value = 'gold',  label = 'Arany',  count = 1, chance = 8, sellPrice = 10},
                {value = 'diamond', label = 'Gyémánt', count = 1, chance = 7, sellPrice = 50},
                {value = 'smaragd',   label = 'Smaragd',   count = 1, chance = 5, sellPrice = 85},
                {value = 'emerald',   label = 'Emeráld',   count = 1, chance = 6, sellPrice = 85},
                {value = 'zapphire',   label = 'Zafír',   count = 1, chance = 4, sellPrice = 85},
                {value = 'sakura',   label = 'Sakura',   count = 1, chance = 5, sellPrice = 85},
            }
        }
    },
    ['grape_picking'] = {
        ['mainPlace'] = {
            ped = {
                model = `A_M_M_BevHills_01`,
                coord = vec3(-1926.9783, 2042.2040, 139.8330),
                heading = 254.2913
            },
            blip = {
                sprite = 351,
                display = 4,
                scale = 1.2,
                colour = 2,
                text = 'Grape Picking'
            }
        },
        ['vehicles'] = {
            plate = 'GRAPE',
            spawnCoord = {
                position = vec3(-1923.9308, 2036.2571, 140.7351), 
                heading = 256.0, 
                radius = 3.0
            },
            list = {
                {label = 'Faggio',     value = 'faggio',     sellPrice = 50}
            }
        },
        ['actions'] = {
            type = 'sphere', -- sphere or box
            sphereData = {
                coord = vec3(-1874.4647, 2127.4763, 129.7854),
                radius = 70.0
            },
            blip = {
                sprite = 587,
                display = 4,
                scale = 0.5,
                colour = 2,
                text = 'Grape Picking area',
                radius = {
                    colour = 2,
                    alpha = 100
                }
            },
            coords = { -- position must be in the zone!
                {position = vector3(-1870.35, 2140.81, 125.04), heading = 100.0},
                {position = vector3(-1880.92, 2141.65, 124.37), heading = 100.0},
                {position = vector3(-1891.48, 2142.48, 122.43), heading = 100.0},
                {position = vector3(-1902.05, 2143.31, 119.5), heading = 100.0}
            },
            action = {
                requiredItem = 'water', -- none or item name

                context = 'Press [E] to start picking',

                skillCheckData = { -- if skill check is true
                    difficulty = {'easy', 'easy', 'easy', 'easy'},
                    inputs = {'w', 'a', 's', 'd'}
                },

                TaskBlipData = {
                    sprite = 1,
                    display = 2,
                    scale = 1.0,
                    colour = 0,
                    text = 'Grape',
                },

                prop = ``,

                anim = {
                    dict = 'mp_common_heist', 
                    name = 'use_terminal_loop'
                },

                progbar = {
                    time = 5000,
                    label = 'Picking grape..',
                    attach = {
                        prop = nil,
                        bone = 57005,
                        pos = vec3(0.1, 0.0, 0.0),
                        rot = vec3(-90.0, 25.0, 35.0)
                    }
                },
            },
            items = {
                {value = 'burger',  label = 'Burger',  count = 1, chance = 5, sellPrice = 10},
                {value = 'garbage', label = 'Garbage', count = 1, chance = 7, sellPrice = 50},
                {value = 'water',   label = 'Water',   count = 1, chance = 6, sellPrice = 85} 
            }
        }
    },
    ['lumberjack'] = {
        ['mainPlace'] = {
            ped = {
                model = `A_M_M_Farmer_01`,
                coord = vec3(-567.4063, 5253.1367, 69.4864),
                heading = 76.4638
            },
            blip = {
                sprite = 351,
                display = 4,
                scale = 1.2,
                colour = 31,
                text = 'Lumberjack'
            }
        },
        ['vehicles'] = {
            plate = 'TREES',
            spawnCoord = {
                position = vec3(-579.8597, 5257.0488, 70.4606), 
                heading = 329.0, 
                radius = 3.0
            },
            list = {
                {label = 'BobCat XL',     value = 'bobcatxl',     sellPrice = 150},
                {label = 'Adder',         value = 'adder',     sellPrice = 150},
                {label = 'Blista',        value = 'blista',     sellPrice = 150}
            }
        },
        ['actions'] = {
            type = 'sphere', -- sphere or box
            sphereData = {
                coord = vec3(-578.4520, 5451.1357, 60.6883), 
                radius = 80.0
            },
            blip = {
                sprite = 587,
                display = 4,
                scale = 0.5,
                colour = 31,
                text = 'Tree cutting area',
                radius = {
                    colour = 31,
                    alpha = 100
                }
            },
            coords = { -- position must be in the zone!
                {position = vec3(-553.4778, 5445.1919, 63.3238), heading = 100.0},
                {position = vec3(-578.2493, 5427.9370, 58.9797), heading = 100.0},
                {position = vec3(-585.8885, 5446.5034, 60.1750), heading = 100.0},
                {position = vec3(-583.3246, 5490.6543, 55.7955), heading = 100.0}
            },
            action = {
                requiredItem = 'water', -- none or item name

                context = 'Press [E] to start cutting the tree',

                skillCheckData = { -- if you dont want skillcheck then set this to false
                    difficulty = {'easy', 'easy', 'easy', 'easy'},
                    inputs = {'w', 'a', 's', 'd'}
                },
                
                TaskBlipData = { -- if you dont want taskblip then set this to false
                    sprite = 1,
                    display = 2,
                    scale = 1.0,
                    colour = 0,
                    text = 'Tree',
                },

                prop = nil, -- nil or prop name

                anim = {
                    dict = 'melee@hatchet@streamed_core_fps',
                    name = 'plyr_front_takedown'
                },

                progbar = {
                    time = 5000,
                    label = 'Cutting tree..',
                    attach = {
                        prop = `prop_tool_fireaxe`, -- nil or prop name
                        bone = 57005,
                        pos = vec3(0.1, 0.0, 0.0),
                        rot = vec3(-90.0, 25.0, 35.0)
                    }
                },
            },
            items = {
                {value = 'burger',  label = 'Burger',  count = 1, chance = 5, sellPrice = 10},
                {value = 'garbage', label = 'Garbage', count = 1, chance = 7, sellPrice = 50},
                {value = 'water',   label = 'Water',   count = 1, chance = 6, sellPrice = 85} 
            }
        }
    }
}