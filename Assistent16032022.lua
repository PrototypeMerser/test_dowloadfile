script_name("Your Assistant")
script_author("Alex Merser")
script_version("1.0 beta")

local imgui = require 'imgui'
local event = require 'samp.events'
local vkey = require "vkeys"
local inicfg = require "inicfg"
local encoding = require "encoding"
local pie = require 'imgui_piemenu'
encoding.default = "CP1251"
u8 = encoding.UTF8

img1 = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\images\\Untitled.jpg")

local NameCommandRp = {
  "/find",
  "/mask",
  "/bk",
  "/wanted",
  "/demoute",
  "/bot",
  "/unbag",
  "/untie",
  "/ungag",
  "/point",
  "/invite",
  "/uninvite",
  "/giverank",
  "/fwarn",
  "/fwarnoff",
  "/unfwarn",
  "/unfwarnoff",
  "/fmute",
  "/fmutes",
  "/funmute",
  "/premium",
  "/su",
  "/unsu",
  "/clear",
  "/take",
  "/frisk",
  "/cuff",
  "/uncuff",
  "/unmask",
  "/pull",
  "/incar",
  "/ticket",
  "/arrest",
  "/gotome",
  "/ungotome",
  "/showbadge",
}

local test_table = {
  [1] = "Кастет",
  [2] = "Клюшка для гольфа",
  [3] = "Полицейская дубинка",
  [4] = "Нож",
  [5] = "Бейсбольная бита",
  [6] = "Лопата",
  [7] = "Кий",
  [8] = "Катана",
  [9] = "Бензопила",
  [10] = "Двухсторонний дилдо",
  [11] = "Дилдо",
  [12] = "Вибратор",
  [13] = "Серебряный вибратор",
  [14] = "Букет цветов",
  [15] = "Трость",
  [16] = "Граната",
  [17] = "Слезоточивый газ",
  [18] = "Коктейль Молотова",
  [22] = "Пистолет 9мм",
  [23] = "Пистолет с глушителем",
  [24] = "Пистолет Desert Eagle",
  [25] = "Обычный дробовик",
  [26] = "Обрез",
  [27] = "Скорострельный дробовик",
  [28] = "Узи",
  [29] = "MP5",
  [30] = "Автомат Калашникова",
  [31] = "Винтовка M4",
  [32] = "Tec-9",
  [33] = "Охотничье ружье",
  [34] = "Снайперская винтовка",
  [35] = "РПГ",
  [36] = "Ракеты HS",
  [37] = "Огнемет",
  [38] = "Миниган",
  [39] = "Сумка с тротилом",
  [40] = "Детонатор к сумке",
  [41] = "Баллончик с краской",
  [42] = "Огнетушитель",
  [43] = "Фотоаппарат",
  [44] = "Прибор ночного видения",
  [46] = "Парашют",
}

local TableMarking = {"DISP", "All", "a", "b", "s", "d", "e", "f", "g"}
local k = "3"
local main_pie_section = {"X", "Y", "Z", "P", "O", "H"}

local mainBind = inicfg.load(nil, "moonloader\\config\\binder_as.ini")
local mainbgun = inicfg.load(nil, "moonloader\\config\\guns.ini")
local mainInterviews = inicfg.load(nil, "moonloader\\config\\interviews.ini")
local mainBinder = inicfg.load(nil, "moonloader\\config\\binder.ini")
local mainCommand = inicfg.load(nil, "moonloader\\config\\commandrp.ini")
local mainDepart = inicfg.load(nil, "moonloader\\config\\departamens.ini")
local mainSetting = inicfg.load(nil, "moonloader\\config\\setting.ini")

local rkeys = require "rkeys"
imgui.HotKey = require('imgui_addons').HotKey
local tLastKeys = {}

local sw, sh = getScreenResolution()

local table_imgui = {
  [1] = "001",
  [2] = "",
  [3] = "",
  [4] = "DISP",
  [5] = "0",
  [6] = "-",
  [7] = "-",
  [8] = false,
  [9] = "-",
  [10] = "1", -- пустой
  [11] = false,
  [12] = false,
  [13] = false,
  [14] = false,
  [15] = imgui.ImInt(0),
  [16] = imgui.ImInt(0),
  [17] = imgui.ImBuffer(u8:decode(mainSetting.setting[1]), 128),
  [18] = imgui.ImBuffer(u8:decode(mainSetting.setting[2]), 128),
  [19] = "",
  [20] = imgui.ImBool(false),
  [21] = imgui.ImBool(false),
  [22] = 39,
  [23] = imgui.ImBool(false),
  [24] = imgui.ImBool(false),
  [25] = false, -- пустой
  [26] = imgui.ImBool(false),
  [27] = imgui.ImBool(false),
  [28] = imgui.ImBool(false),
  [29] = imgui.ImInt(-1), -- пустой
  [30] = imgui.ImBool(false),
  [31] = "-",
  [32] = imgui.ImInt(-1), -- пустой
  [33] = "",
  [34] = false,
  [35] = false,
  [36] = "Не принято",
  [37] = imgui.ImVec4(0.61, 0.58, 0.58, 1.0),
  [38] = imgui.ImInt(-1),
  [39] = "---",
  [40] = "---",
  [41] = "---",
  [42] = "---", -- пустой
  [43] = "---",
  [44] = "---",
  [45] = "---",
  [46] = "---", -- пустой
  [47] = "---",
  [48] = "---",
  [49] = "---",
  [50] = "---", -- пустой
  [51] = "---",
  [52] = "---",
  [53] = "---",
  [54] = "---", -- пустой 
  [55] = "---",
  [56] = "---",
  [57] = "---",
  [58] = "---", -- пустой
  [59] = "---",
  [60] = "---",
  [61] = "---",
  [62] = "---", -- пустой
  [63] = "---",
  [64] = "---",
  [65] = "---",
  [66] = "---", -- пустой
  [67] = "---",
  [68] = "---",
  [69] = "---",
  [70] = "---", -- пустой
  [71] = "---",
  [72] = "---",
  [73] = "---",
  [74] = "---", -- пустой
  [75] = "---",
  [76] = "---",
  [77] = "---",
  [78] = "---",
  [79] = "---",
  [80] = imgui.ImBuffer(128),
  [81] = imgui.ImBuffer(256),
  [82] = "",
  [83] = imgui.ImBool(mainDepart.setting[2]),
  [84] = imgui.ImBuffer(mainSetting.setting[9], 256),
  [85] = imgui.ImInt(-1), -- пустой
  [86] = imgui.ImBuffer(16),
  [87] = imgui.ImBuffer(16),
  [88] = imgui.ImBuffer(16),
  [89] = imgui.ImBuffer(32768),
  [90] = "---",
  [91] = "---",
  [92] = 39,
  [93] = "-",
  [94] = "-",
  [95] = imgui.ImVec4(0.12, 0.41, 2.32, 1.00), -- пустой
  [96] = "1", -- пустой
  [97] = imgui.ImInt(0),
  [98] = "1", -- пустой
  [99] = "-",
  [100] = "-",
  [101] = "1",
  [102] = "1",
  [103] = "1",
  [104] = "1",
  [105] = "1",
  [106] = imgui.ImBool(false),
  [107] = imgui.ImBuffer(256),
  [108] = imgui.ImBool(false),
  [109] = imgui.ImBuffer(256),
  [110] = "1",
  [111] = imgui.ImBool(false),
  [112] = "1",
  [113] = false,
  [114] = imgui.ImBool(mainbgun.setting[1]),
  [115] = "",
  [116] = "",
  [117] = "",
  [118] = imgui.ImBool(false), -- пустой
  [119] = imgui.ImBool(false), -- пустой
  [120] = imgui.ImBool(false), -- пустой
  [121] = imgui.ImBool(false), -- пустой
  [122] = imgui.ImBool(false), -- пустой
  [123] = "", -- пустой
  [124] = imgui.ImBool(false), -- пустой
  [125] = imgui.ImBool(false), -- пустой
  [126] = imgui.ImBool(false), -- пустой
  [127] = imgui.ImBool(false), -- пустой
  [128] = imgui.ImBool(false), -- пустой
  [129] = imgui.ImBool(false), -- пустой
  [130] = imgui.ImBool(false), -- пустой
  [131] = imgui.ImBool(false), -- пустой
  [132] = imgui.ImBool(false), -- пустой
  [133] = imgui.ImBool(false), -- пустой
  [134] = imgui.ImBool(false), -- пустой
  [135] = imgui.ImBool(false), -- пустой
  [136] = "", -- пустой
  [137] = imgui.ImBool(false), -- пустой
  [138] = imgui.ImBool(false), -- пустой
  [139] = imgui.ImBool(false), -- пустой
  [140] = imgui.ImBool(false), -- пустой
  [141] = "", -- пустой
  [142] = "", -- пустой
  [143] = "", -- пустой
  [144] = "", -- пустой
  [145] = imgui.ImBool(false), -- пустой
  [146] = imgui.ImBool(false), -- пустой
  [147] = imgui.ImBool(false), -- пустой
  [148] = imgui.ImBool(false), -- пустой
  [149] = imgui.ImBool(false), -- пустой
  [150] = imgui.ImBool(false), -- пустой
  [151] = imgui.ImBool(false), -- пустой
  [152] = imgui.ImBool(false), -- пустой
  [153] = imgui.ImBool(false), -- пустой
  [154] = imgui.ImBool(false), -- пустой
  [155] = imgui.ImBool(false), -- пустой
  [156] = imgui.ImBool(false), -- пустой
  [157] = false, -- пустой
  [158] = true, -- пустой
  [159] = imgui.ImBool(false), -- пустой
  [160] = true, -- пустой
  [161] = false, -- пустой
  [162] = false, -- присвоение только false
  [163] = true, -- присвоение только true
  [164] = imgui.ImBool(mainbgun.setting[2]),
  [165] = false, -- пустой
  [166] = true, -- пустой
  [167] = false, -- пустой
  [168] = true, -- пустой
  [169] = false, -- пустой
  [170] = true, -- пустой
  [171] = false, -- пустой
  [172] = true, -- пустой
  [173] = imgui.ImInt(0),
  [174] = imgui.ImBool(false),
  [175] = "1", -- пустой
  [176] = false,
  [177] = imgui.ImBool(false),
  [178] = imgui.ImInt(-1), -- пустой
  [179] = imgui.ImBool(false),
  [180] = imgui.ImBuffer(4096),
  [181] = imgui.ImInt(-1), -- пустой
  [182] = imgui.ImInt(-1),
  [183] = 10, -- пустой
  [184] = imgui.ImInt(-1), -- пустой
  [185] = imgui.ImInt(-1), -- пустой
  [186] = 1, -- пустой
  [187] = imgui.ImBuffer(256),
  [188] = imgui.ImBuffer(16),
  [189] = 0,
  [190] = imgui.ImBool(mainSetting.setting[10]),
  [191] = imgui.ImInt(-1), -- пустой
  [192] = "-",
  [193] = imgui.ImBuffer(532),
  [194] = imgui.ImBool(false),
  [195] = imgui.ImBuffer(16),
  [196] = "",
  [197] = "---",
  [198] = 0,
  [199] = imgui.ImBuffer(532),
  [200] = true,
  [201] = "0",
  [202] = false,
  [203] = false,
  [204] = false,
  [205] = false,
  [206] = imgui.ImInt(-1),
  [207] = imgui.ImInt(-1),
  [208] = imgui.ImBuffer(64),
  [209] = "",
  [210] = imgui.ImBool(mainDepart.setting[1]),
  [211] = imgui.ImInt(mainSetting.setting[12]),
  [212] = imgui.ImBool(mainSetting.setting[13]),
  [213] = imgui.ImBool(false),
  [214] = imgui.ImBool(false),
  [215] = 1,
  [216] = 1,
  [217] = 1,
  [218] = 1,
  [219] = imgui.ImBool(false),
  [220] = imgui.ImBool(false),
  [221] = 0, -- пустой
  [222] = "No",
  [223] = "No",
  [224] = imgui.ImBuffer(512),
  [225] = imgui.ImBuffer(64),
  [226] = imgui.ImBuffer(16),
  [227] = "-",
  [228] = imgui.ImBool(false),
  [229] = "",
  [230] = imgui.ImBool(mainSetting.setting[7]),
  [231] = imgui.ImBool(mainSetting.setting[8]),
  [232] = imgui.ImBuffer(1024),
  [233] = imgui.ImBool(mainSetting.setting[14]),
  [234] = imgui.ImBuffer(64),
  [235] = imgui.ImBuffer(16),
  [236] = "",
  [237] = imgui.ImBool(false),
  [238] = false,
  [239] = imgui.ImBuffer(256), -- пустой
  [240] = "", -- пустой
  [241] = imgui.ImBuffer(32), -- пустой
  [242] = imgui.ImBuffer(u8:decode(mainSetting.setting[3]), 32),
  [243] = imgui.ImBool(mainSetting.setting[4]),
  [244] = imgui.ImBool(mainSetting.setting[5]),
  [245] = imgui.ImBool(mainSetting.setting[6]),
  [246] = "",
}

table_imgui[93], table_imgui[94] = string.match(mainSetting.setting[1], "(%u)%l+%s*(%u%l+)")

local checkbox_bool = {
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
  imgui.ImBool(false),
}

local rcsd = {
  "Blueberry Acres",
  "Fern Ridge",
  "Red County",
  "Fisher's Lagoon",
  "Hampton Barns",
  "Hilltop Farm",
  "Montgomery Intersection",
  "Montgomery",
  "North Rock",
  "The Panopticon",
  "Dillimore",
  "Flint Range",
  "Flint County",
  "Los Santos Inlet",
  "Whetstone",
  "Shady Creeks",
  "Angel Pine",
  "Mount Chiliad",
  "Back o Beyond",
  "Beacon Hill",
  "Easter Bay Chemicals",
  "Easter Tunnel",
  "Fallen Tree",
  "Flint Intersection",
  "Leafy Hollow",
  "The Farm",
  "Shady Cabin",
  "Palomino Creek",
  "Frederick Bridge",
  "Martin Bridge",
  "",
}

local lvpd = {
  "Blackfield Intersection",
  "Blackfield Chapel",
  "Blackfield",
  "Greenglass College",
  "Las Venturas Airport",
  "Linden Side",
  "Old Venturas Strip",
  "Pilgrim",
  "Prickle Pine",
  "Redsands East",
  "Redsands West",
  "Roca Escalante",
  "Rockshore East",
  "Rockshore West",
  "Spinybed",
  "The Strip",
  "Whitewood Estates",
  "Last Dime Motel",
  "Linden Station",
  "LVA Freight Depot",
  "Randolph Industrial Estate",
  "Sobell Rail Yards",
  "Yellow Bell Station",
  "The Camel's Toe",
  "Harry Gold Parkway",
  "Julius Thruway West",
  "Julius Thruway North",
  "Julius Thruway East",
  "Julius Thruway South",
  "Pilson Intersection",
  "El Castillo del Diablo",
  "Hunter Quarry",
  "Green Palms",
  "Lil' Probe Inn",
  "Octane Springs",
  "Regular Tom",
  "The Big Ear",
  "Verdant Meadows",
  "Bone County",
  "Arco del Oeste",
  "Sherman Reservoir",
  "The Sherman Dam",
  "Las Venturas",
  "The Emerald Isle",
  "Starfish Casino",
  "The Clown's Pocket",
  "The Visage",
}

local sfpd = {
  "Battery Point",
  "Gant Bridge",
  "Garver Bridge",
  "Juniper Hollow",
  "Paradiso",
  "Esplanade North",
  "Esplanade East",
  "Downtown",
  "Financial",
  "Calton Heights",
  "Chinatown",
  "Juniper Hill",
  "Palisades",
  "Santa Flora",
  "City Hall",
  "Queens",
  "King's",
  "Easter Basin",
  "Doherty",
  "Cranberry Station",
  "Garcia",
  "Hashbury",
  "Ocean Flats",
  "Avispa Country Club",
  "Missionary Hill",
  "Foster Valley",
  "Easter Bay Airport",
  "San Fierro",
  "Tierra Robada",
  "Robada Intersection",
  "Bayside Tunnel",
  "Bayside",
  "Bayside Marina",
  "El Quebrados",
  "Las Barrancas",
}

local lspd = {
  "Downtown Los Santos",
  "Pershing Square",
  "Commerce",
  "Mulholland Intersection",
  "Verdant Bluffs",
  "Mulholland",
  "Richman",
  "Rodeo",
  "Vinewood",
  "Temple",
  "Market",
  "Santa Maria Beach",
  "Verona Beach",
  "Marina",
  "East Beach",
  "Playa del Seville",
  "East Los Santos",
  "El Corona",
  "Little Mexico",
  "Ganton",
  "Idlewood",
  "Jefferson",
  "Glen Park",
  "Las Colinas",
  "Los Flores",
  "Willowfield ",
  "Ocean Docks",
  "Los Santos",
  "Los Santos International",
}

local table_binder = {
  [1] = {
    v = decodeJson(mainBinder[1].key)
  },
  [2] = {
    v = decodeJson(mainBinder[2].key)
  },
  [3] = {
    v = decodeJson(mainBinder[3].key)
  },
  [4] = {
    v = decodeJson(mainBinder[4].key)
  },
  [5] = {
    v = decodeJson(mainBinder[5].key)
  },
  [6] = {
    v = decodeJson(mainBinder[6].key)
  },
  [7] = {
    v = decodeJson(mainBinder[7].key)
  },
  [8] = {
    v = decodeJson(mainBinder[8].key)
  },
  [9] = {
    v = decodeJson(mainBinder[9].key)
  },
  [10] = {
    v = decodeJson(mainBinder[10].key)
  },
  [11] = {
    v = decodeJson(mainBinder[11].key)
  },
  [12] = {
    v = decodeJson(mainBinder[12].key)
  },
  [13] = {
    v = decodeJson(mainBinder[13].key)
  },
  [14] = {
    v = decodeJson(mainBinder[14].key)
  },
  [15] = {
    v = decodeJson(mainBinder[15].key)
  },
  [16] = {
    v = decodeJson(mainBinder[16].key)
  },
  [17] = {
    v = decodeJson(mainBinder[17].key)
  },
  [18] = {
    v = decodeJson(mainBinder[18].key)
  },
  [19] = {
    v = decodeJson(mainBinder[19].key)
  },
  [20] = {
    v = decodeJson(mainBinder[20].key)
  },
  [21] = {
    v = decodeJson(mainBinder[21].key)
  },
  [22] = {
    v = decodeJson(mainBinder[22].key)
  },
  [23] = {
    v = decodeJson(mainBinder[23].key)
  },
  [24] = {
    v = decodeJson(mainBinder[24].key)
  },
}

local CheckboxButtonRp = {
  imgui.ImBool(mainCommand[1].enabled),
  imgui.ImBool(mainCommand[2].enabled),
  imgui.ImBool(mainCommand[3].enabled),
  imgui.ImBool(mainCommand[4].enabled),
  imgui.ImBool(mainCommand[5].enabled),
  imgui.ImBool(mainCommand[6].enabled),
  imgui.ImBool(mainCommand[7].enabled),
  imgui.ImBool(mainCommand[8].enabled),
  imgui.ImBool(mainCommand[9].enabled),
  imgui.ImBool(mainCommand[10].enabled),
  imgui.ImBool(mainCommand[11].enabled),
  imgui.ImBool(mainCommand[12].enabled),
  imgui.ImBool(mainCommand[13].enabled),
  imgui.ImBool(mainCommand[14].enabled),
  imgui.ImBool(mainCommand[15].enabled),
  imgui.ImBool(mainCommand[16].enabled),
  imgui.ImBool(mainCommand[17].enabled),
  imgui.ImBool(mainCommand[18].enabled),
  imgui.ImBool(mainCommand[19].enabled),
  imgui.ImBool(mainCommand[20].enabled),
  imgui.ImBool(mainCommand[21].enabled),
  imgui.ImBool(mainCommand[22].enabled),
  imgui.ImBool(mainCommand[23].enabled),
  imgui.ImBool(mainCommand[24].enabled),
  imgui.ImBool(mainCommand[25].enabled),
  imgui.ImBool(mainCommand[26].enabled),
  imgui.ImBool(mainCommand[27].enabled),
  imgui.ImBool(mainCommand[28].enabled),
  imgui.ImBool(mainCommand[29].enabled),
  imgui.ImBool(mainCommand[30].enabled),
  imgui.ImBool(mainCommand[31].enabled),
  imgui.ImBool(mainCommand[32].enabled),
  imgui.ImBool(mainCommand[33].enabled),
  imgui.ImBool(mainCommand[34].enabled),
  imgui.ImBool(mainCommand[35].enabled),
  imgui.ImBool(mainCommand[36].enabled),
}

local tegs_desc = {
  {"<district>", "Район"},
  {"<square>", "Квадрат"},
  {"<time>", "Время (00:00:00)"},
  {"<date>", "Дата (00/00/00)"},
  {"<wait_2>", "Задержка (в секундах)"},
  {"<target_player>", "Выделенный игрок (ник)"},
  {"<city>", "Город"},
  {"<marking_number>", "Маркировка и номер (D-4)"},
  {"<to>", "Обращение к (рация)"},
  {"<target_id>", "Выделенный игрок (айди)"},
  {"<chat_enabled>", "Открыть окно ввод"},
  {"<input_chat> text", "Вставить текст в окно"},
  {"<departament>", "Ваш департамент"},
  {"<phone>", "Ваш номер телефона"},
  {"<driver>", "Айди ближайшего водителя"},
  {"<myid>", "Ваш айди"},
  -- {"<>", ""},
}

local file = io.open("moonloader\\config\\ustav.ini", "r")
  if file then  
    table_imgui[78] = file:read("*a")
    table_imgui[89].v = u8(table_imgui[78])
    file:close()
  end

local fileuk = io.open("moonloader\\config\\CriminalСode.json", "r")
  if fileuk then
    ug_codex = {}
    ug_codex = decodeJson(fileuk:read('*a'))
    fileuk:close()
  end
  local fileak = io.open("moonloader\\config\\AdministrativeCode.json", "r")
  if fileak then
    ak_codex = {}
    ak_codex = decodeJson(fileak:read('*a'))
    fileak:close()
  end

function SetStyle()
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
  colors[clr.TextDisabled] = ImVec4(0.15, 0.46, 0.65, 1.00)
  colors[clr.WindowBg] = ImVec4(0.00, -0.10, 0.00, 1.00)
  colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
  colors[clr.PopupBg] = ImVec4(0.15, 0.46, -0.65, 1.00)
  colors[clr.Border] = ImVec4(0.66, 0.64, 0.64, 1.00)
  colors[clr.BorderShadow] = ImVec4(0.55, 1.38, 0.63, 0.00)
  colors[clr.FrameBg] = ImVec4(0.10, 0.10, 0.10, 1.00) -- фон инпут, чекбокс и на подобии
  colors[clr.FrameBgHovered] = ImVec4(0.30, 0.30, 0.30, 0.80)
  colors[clr.FrameBgActive] = ImVec4(0.15, 0.46, -0.65, 1.00)
  colors[clr.TitleBg] = ImVec4(0.13, 0.13, 0.13, 1.00)
  colors[clr.TitleBgCollapsed] = ImVec4(0.30, 0.31, 0.33, 0.80)
  colors[clr.TitleBgActive] = ImVec4(0.09, 0.10, 0.09, 1.00) -- верхняя часть окна
  colors[clr.MenuBarBg] = ImVec4(-0.40, 0.76, -0.65, 1.00)
  colors[clr.ScrollbarBg] = ImVec4(0.00, 0.46, 0.65, 0.00)
  colors[clr.ScrollbarGrab] = ImVec4(0.23, 0.23, 0.23, 0.60)
  colors[clr.ScrollbarGrabHovered] = ImVec4(0.48, 0.48, 0.48, 0.55)
  colors[clr.ScrollbarGrabActive] = ImVec4(0.50, 0.50, 0.48, 0.55)
  colors[clr.ComboBg] = ImVec4(0.15, 0.14, 0.15, 1.00)
  colors[clr.CheckMark] = ImVec4(0.25, 0.50, 0.15, 1.00)
  colors[clr.SliderGrab] = ImVec4(0.0, 0.46, 0.65, 1.00)
  colors[clr.SliderGrabActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
  colors[clr.Button] = ImVec4(0.15, 0.35, 0.75, 0.70)
  colors[clr.ButtonHovered] = ImVec4(0.10, 0.35, 0.75, 0.80)
  colors[clr.ButtonActive] = ImVec4(0.02, 0.10, 0.20, 0.75)
  colors[clr.Header] = ImVec4(0.00, 0.46, 0.65, 1.00)
  colors[clr.HeaderHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
  colors[clr.HeaderActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
  colors[clr.ResizeGrip] = ImVec4(-0.27, -0.90, 0.89, 1.00)
  colors[clr.ResizeGripHovered] = ImVec4(0.15, 0.46, 0.65, 1.00)
  colors[clr.ResizeGripActive] = ImVec4(0.27, -0.90, 0.89, 1.00)
  colors[clr.CloseButton] = ImVec4(0.33, 0.31, 0.31, 0.65)
  colors[clr.CloseButtonHovered] = ImVec4(0.35, 0.35, 0.35, 0.80)
  colors[clr.CloseButtonActive] = ImVec4(0.09, 0.10, 0.09, 1.00)
  colors[clr.PlotLines] = ImVec4(0.27, -0.90, 0.89, 1.00)
  colors[clr.PlotLinesHovered] = ImVec4(0.27, -0.90, 0.89, 1.00)
  colors[clr.PlotHistogram] = ImVec4(0.15, 0.46, 0.65, 1.00)
  colors[clr.PlotHistogramHovered] = ImVec4(0.15, 0.46, 0.65, 1.00)
  colors[clr.TextSelectedBg] = ImVec4(1.17, 1.17, 1.17, 0.50)
  colors[clr.ModalWindowDarkening] = ImVec4(0.04, 0.10, 0.20, 0.51)
end
SetStyle()

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then
		return
	end
	while not isSampAvailable() do
		wait(0)
	end

  autoupdate("https://raw.githubusercontent.com/PrototypeMerser/autoupdate/main/autoupdate.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/PrototypeMerser/autoupdate/main/autoupdate.json")

  lua_thread.create(function()
    wait(5000)
    sampAddChatMessage("{696969} >| {00BB00}Скрипт {ff692e}YourAssistant {00BB00}[{ff692e}" .. thisScript().version .. "{00BB00}] успешно запустился. Разработчик: {ff692e}Alex Merser.", -1)
    sampAddChatMessage("{696969} >| {00BB00}Основные команды: {bababa}/as, /pat, /dp, /disp, /setpost /10-55 {00BB00}Приятной игры!", -1)
  end)
	
	mass_bind = {
    [1] = rkeys.registerHotKey(table_binder[1].v, true, clockFunc1),
    [2] = rkeys.registerHotKey(table_binder[2].v, true, clockFunc1),
    [3] = rkeys.registerHotKey(table_binder[3].v, true, clockFunc1),
    [4] = rkeys.registerHotKey(table_binder[4].v, true, clockFunc1),
    [5] = rkeys.registerHotKey(table_binder[5].v, true, clockFunc1),
    [6] = rkeys.registerHotKey(table_binder[6].v, true, clockFunc1),
    [7] = rkeys.registerHotKey(table_binder[7].v, true, clockFunc1),
    [8] = rkeys.registerHotKey(table_binder[8].v, true, clockFunc1),
    [9] = rkeys.registerHotKey(table_binder[9].v, true, clockFunc1),
    [10] = rkeys.registerHotKey(table_binder[10].v, true, clockFunc1),
    [11] = rkeys.registerHotKey(table_binder[11].v, true, clockFunc1),
    [12] = rkeys.registerHotKey(table_binder[12].v, true, clockFunc1),
    [13] = rkeys.registerHotKey(table_binder[13].v, true, clockFunc1),
    [14] = rkeys.registerHotKey(table_binder[14].v, true, clockFunc1),
    [15] = rkeys.registerHotKey(table_binder[15].v, true, clockFunc1),
    [16] = rkeys.registerHotKey(table_binder[16].v, true, clockFunc1),
    [16] = rkeys.registerHotKey(table_binder[17].v, true, clockFunc1),
    [17] = rkeys.registerHotKey(table_binder[18].v, true, clockFunc1),
    [18] = rkeys.registerHotKey(table_binder[19].v, true, clockFunc1),
    [19] = rkeys.registerHotKey(table_binder[20].v, true, clockFunc1),
    [20] = rkeys.registerHotKey(table_binder[21].v, true, clockFunc1),
    [21] = rkeys.registerHotKey(table_binder[22].v, true, clockFunc1),
    [22] = rkeys.registerHotKey(table_binder[23].v, true, clockFunc1),
    [23] = rkeys.registerHotKey(table_binder[24].v, true, clockFunc1),
    [24] = rkeys.registerHotKey(table_binder[24].v, true, clockFunc1),
	}

	sampRegisterChatCommand("setpost", PostMenu)
	sampRegisterChatCommand("disp",DispatchMenu)
	sampRegisterChatCommand("sap", SapFast)
	sampRegisterChatCommand("as", AssistantMenu)
	sampRegisterChatCommand("pat", PatrolMenu)
	sampRegisterChatCommand("dp", DepartmentMenu)
  sampRegisterChatCommand("ticket", ComTicket)
	sampRegisterChatCommand("su", ComSu)
	sampRegisterChatCommand("10-55", TraficMenu)
  sampRegisterChatCommand("mirand", ComMirand)

	threads_units = lua_thread.create_suspended(PatrolUnits)
	threads_command = lua_thread.create_suspended(RpCommand)
	threads_su_umn = lua_thread.create_suspended(func_su_umn)
	thread_cmen = lua_thread.create_suspended(thread_function)
  thread_reload = lua_thread.create_suspended(reload_script)
  thread_su_zapros = lua_thread.create_suspended(su_zapros)
  thread_siren = lua_thread.create_suspended(siren_police) --!!

	while true do
		wait(0)

    -- downloadUrlToFile("https://raw.githubusercontent.com/PrototypeMerser/test_dowloadfile/main/ARZ_Phoenix_UK.json", getWorkingDirectory().."/audio/ARZ_Phoenix_UK.json", function(id, status, p1, p2)
    --   -- sampAddChatMessage(status, -1)
    -- end)

    returnchat = sampGetChatString(99)

    dialogactive = sampIsDialogActive()

		_, ind = sampGetPlayerIdByCharHandle(PLAYER_PED)

    int_color = sampGetPlayerColor(ind)

    result_in_chat = sampIsChatInputActive()

    if wasKeyPressed(vkey.VK_X) then
      if not result_in_chat and not dialogactive then
        table_imgui[203] = not table_imgui[203]
      end
    end

    local int_city = getCityPlayerIsIn(PLAYER_HANDLE)
    if int_city == 0 then
      table_imgui[229] = "За городом"
    elseif int_city == 1 then
      table_imgui[229] = "Лос-Сантос"
    elseif int_city == 2 then
      table_imgui[229] = "Сан-Фиерро"
    elseif int_city == 3 then
      table_imgui[229] = "Лас-Вентурас"
    end

		if not table_imgui[20].v and not table_imgui[21].v and not table_imgui[24].v and not table_imgui[26].v and not table_imgui[27].v and not table_imgui[23].v 
		and not table_imgui[28].v and not table_imgui[30].v and not table_imgui[106].v and not table_imgui[177].v and not table_imgui[174].v then
			imgui.Process = false
			imgui.ShowCursor = false
		elseif table_imgui[20].v or table_imgui[24].v or table_imgui[26].v or table_imgui[27].v or table_imgui[23].v or table_imgui[28].v or table_imgui[30].v or 
		table_imgui[106].v or table_imgui[177].v then
			imgui.Process = true
			imgui.ShowCursor = true
    elseif table_imgui[174].v then
      imgui.ShowCursor = table_imgui[203]
    elseif table_imgui[21].v then
			imgui.ShowCursor = table_imgui[203]
      imgui.Process = table_imgui[21].v
	  end

    if isKeyJustPressed(vkey.VK_XBUTTON1) and table_imgui[190].v then
			table_imgui[177].v = not table_imgui[177].v 
			imgui.GetIO().MousePos = imgui.ImVec2(sw / 2, sh / 2)
		end

		if table_imgui[164].v then
			guns_rp()
		end

		if table_imgui[36] == "Принято" and not result_in_chat and not dialogactive then
		  if wasKeyPressed(vkey.VK_G) then
			  sampSetChatInputEnabled(true)
			  sampSetChatInputText("/r [DISP] to []:  , over.")
	  	end
		end

		bres, ped_targeting = getCharPlayerIsTargeting(PLAYER_HANDLE)
		if bres then
			local bres1, inteid = sampGetPlayerIdByCharHandle(ped_targeting)
			if bres1 then
				table_imgui[19] = inteid
        local sub_name = sampGetPlayerNickname(inteid)
        local sub_score = sampGetPlayerScore(inteid)
        local sub_number1, sub_number2  = string.match(sub_name, "(%a*)_(%a*)")
        table_imgui[222] = sub_number1 .. " " .. sub_number2
        table_imgui[223] = sub_score
			end
		end

		if table_imgui[231].v then
      if table_imgui[115] ~= "" and table_imgui[116] ~= "" and table_imgui[117] ~= "" then
		  	table_imgui[26].v = true
				table_imgui[5] = "1"
			end
			if returnchat then
        local text_chat_r1 = returnchat:match("в розыск дело [N№][-]?[ ]?(%d*)")
				local text_chat_r_level = returnchat:match("(%d*%.%d*%p-%d-%p-)[ ]?[ЕФКУКАК]")
				local text_chat_r_step = returnchat:match("(%d*)[ ]?[степеньуров]")
        if table_imgui[5] == "0" then
          if text_chat_r1 then
            table_imgui[115] = text_chat_r1
          end
          if text_chat_r_level then
            table_imgui[117] = text_chat_r_level
          end
          if text_chat_r_step then
            table_imgui[116] = text_chat_r_step
          end
        end
		  end
	  end

    if table_imgui[211].v ~= -1 then
      window_jurisdiction(table_imgui[211].v)
    end

	end
end

function MarkingChat()
  if cut_string_chat and cut_string_chat ~= table_imgui[90] then
    k = "3"
    for v in pairs(TableMarking) do
      for i = 3, 9, 1 do
        if cut_string_chat == TableMarking[i] then
          k = "4"
        end
      end
      if cut_string_chat ~= v and k == "3" and cut_string_chat ~= table.concat(table_imgui, "-", 2, 3) then
        table_imgui[90] = cut_string_chat
        table.insert(TableMarking, 3, cut_string_chat)
        table.remove(TableMarking, 10)
        k = "4"
      end
    end
  end
end

function SapFast()
  sampSendChat("/s Руки держать над головой, Вы арестованы! Неподчинение карается применением силы!")
end

function window_jurisdiction(agr_department)
  if int_color == 2147502591 or int_color == 23486046 then
    for i, v in ipairs(rcsd) do
      if rajon() == v then
        if agr_department ~= 0 and table_imgui[218] == 1 then
          table_imgui[30].v = true
          table_imgui[31] = "РКШД"
          table_imgui[218] = 0
          table_imgui[215] = 1
          table_imgui[216] = 1
          table_imgui[217] = 1
        elseif agr_department == 0 and table_imgui[218] == 1 then
          table_imgui[31] = "РКШД"
          table_imgui[218] = 0
          table_imgui[215] = 1
          table_imgui[216] = 1
          table_imgui[217] = 1
        end
      end
    end
      for i, v in ipairs(lspd) do
        if rajon() == v then
          if agr_department ~= 3 and table_imgui[217] == 1 then
            table_imgui[30].v = true
            table_imgui[31] = "ЛСПД"
            table_imgui[217] = 0
            table_imgui[216] = 1
            table_imgui[215] = 1
            table_imgui[218] = 1
          elseif agr_department == 3 and table_imgui[217] == 1 then
            table_imgui[31] = "ЛСПД"
            table_imgui[217] = 0
            table_imgui[216] = 1
            table_imgui[215] = 1
            table_imgui[218] = 1
          end
        end
      end
    for i, v in ipairs(lvpd) do
      if rajon() == v then
        if agr_department ~= 1 and table_imgui[215] == 1 then
          table_imgui[30].v = true
          table_imgui[31] = "ЛВПД"
          table_imgui[215] = 0
          table_imgui[216] = 1
          table_imgui[217] = 1
          table_imgui[218] = 1
        elseif agr_department == 1 and table_imgui[215] == 1 then
          table_imgui[31] = "ЛВПД"
          table_imgui[215] = 0
          table_imgui[216] = 1
          table_imgui[217] = 1
          table_imgui[218] = 1
        end
      end
    end
    for i, v in ipairs(sfpd) do
      if rajon() == v then
        if agr_department ~= 2 and table_imgui[216] == 1 then
          table_imgui[30].v = true
          table_imgui[31] = "СФПД"
          table_imgui[216] = 0
          table_imgui[217] = 1
          table_imgui[215] = 1
          table_imgui[218] = 1
        elseif agr_department == 2 and table_imgui[216] == 1 then
          table_imgui[31] = "СФПД"
          table_imgui[216] = 0
          table_imgui[217] = 1
          table_imgui[215] = 1
          table_imgui[218] = 1
        end
      end
    end
  end
end

function thread_function(option)
	if string.sub(option, 1, 4) == "bind" then
		local ind = tonumber(string.sub(option, 5))
		for i = 1, 30 do
			if mainBind[ind][i] ~= nil then
				if mainBind[ind][i] == "" then
					sampAddChatMessage("{696969} >| {1adb6e}Обнаружена пустая строка.", -1)
				else
          sampProcessChatInput(u8:decode(mainBind[ind][i]))
          if not number_wait then
            wait(tonumber(mainBind[ind].wait .. "000"))
          elseif number_wait then
            wait(tonumber(number_wait .. "000"))
            number_wait = nil
          end
				end
			else
				return
			end
		end
		return
  elseif string.sub(option, 1, 9) == "interview" then
    local ind = tonumber(string.sub(option, 10))
    for i = 1, 30 do
      if mainInterviews[ind][i] ~= nil then
        if mainInterviews[ind][i] == "" then
          sampAddChatMessage("{696969} >| {1adb6e}Обнаружена пустая строка.", -1)
        else
          sampProcessChatInput(u8:decode(mainInterviews[ind][i]))
          if not number_wait then
            wait(tonumber(mainInterviews[ind].wait .. "000"))
          elseif number_wait then
            wait(tonumber(number_wait .. "000"))
            number_wait = nil
          end
        end
      else
        return
      end
    end
    return
  elseif string.sub(option, 1, 4) == "keys" then
      local ind = tonumber(string.sub(option, 5))
      for i = 1, 30 do
        if mainBinder[ind][i] ~= nil then
          if mainBinder[ind][i] == "" then
            sampAddChatMessage("{696969} >| {1adb6e}Обнаружена пустая строка.", -1)
          else
            sampProcessChatInput(u8:decode(mainBinder[ind][i]))
            if not number_wait then
              wait(tonumber(mainBinder[ind].wait .. "000"))
            elseif number_wait then
              wait(tonumber(number_wait .. "000"))
              number_wait = nil
            end
          end
        else
          return
        end
      end
      return
  end
end

function ComMirand()
  lua_thread.create(function() 
    sampSendChat("Вы имеете право хранить молчание.") 
    wait(1800) 
    sampSendChat("Всё, что вы скажете, может и будет использовано против вас в суде.")
    wait(1800) 
    sampSendChat("Ваш адвокат может присутствовать при допросе.")
    wait(1800) 
    sampSendChat("Если вы не можете оплатить услуги адвоката, он будет предоставлен вам государством.")
    wait(1800) 
    sampSendChat("Вы понимаете свои права?")
  end)
end

function guns_rp()
  table_imgui[198] = getCurrentCharWeapon(PLAYER_PED)
  if table_imgui[198] ~= 0 and mainbgun[table_imgui[198]] then
    table_imgui[202] = mainbgun[table_imgui[198]].enabled
  end
  if table_imgui[202] then
    if not table_imgui[114].v then
      if table_imgui[198] ~= 0 and table_imgui[200] and wasKeyPressed(vkey.VK_RBUTTON) then -- если ид оружия не ноль
        table_imgui[200] = false
        table_imgui[201] = table_imgui[198]
        for i = 1, 30 do
          if mainbgun[table_imgui[198]][i] then
            if mainbgun[table_imgui[198]][i] == "" then
              sampAddChatMessage("{696969} >| {1adb6e}Обнаружена пустая строка.", -1)
            else
              sampSendChat(u8:decode(mainbgun[table_imgui[198]][i]))
              wait(tonumber(mainbgun[table_imgui[198]].wait .. "000"))
            end
          else
            return
          end
        end
      elseif table_imgui[201] ~= table_imgui[198] and not table_imgui[200] then
        table_imgui[200] = true
        for i = 1, 30 do
          if mainbgun[table_imgui[201] + 50][i] then
            if mainbgun[table_imgui[201] + 50][i] == "" then
              sampAddChatMessage("{696969} >| {1adb6e}Обнаружена пустая строка.", -1)
            else
              sampSendChat(u8:decode(mainbgun[table_imgui[201] + 50][i]))
              wait(tonumber(mainbgun[table_imgui[201]].wait .. "000"))
            end
          else
            return
          end
        end
      end
    elseif table_imgui[114].v then
      if table_imgui[198] ~= 0 and table_imgui[200] and bres then 
        table_imgui[200] = false
        table_imgui[201] = table_imgui[198]
        for i = 1, 30 do
          if mainbgun[table_imgui[198]][i] then
            if mainbgun[table_imgui[198]][i] == "" then
              sampAddChatMessage("{696969} >| {1adb6e}Обнаружена пустая строка.", -1)
            else
              sampSendChat(u8:decode(mainbgun[table_imgui[198]][i]))
              wait(tonumber(mainbgun[table_imgui[198]].wait .. "000"))
            end
          else
            return
          end
        end
      elseif table_imgui[201] ~= table_imgui[198] and not table_imgui[200] then
        table_imgui[200] = true
        for i = 1, 30 do
          if mainbgun[table_imgui[201] + 50][i] then
            if mainbgun[table_imgui[201] + 50][i] == "" then
              sampAddChatMessage("{696969} >| {1adb6e}Обнаружена пустая строка.", -1)
            else
              sampSendChat(u8:decode(mainbgun[table_imgui[201] + 50][i]))
              wait(tonumber(mainbgun[table_imgui[201]].wait .. "000"))
            end
          else
            return
          end
        end
      end
    end
  end
end

function dispetch()
  local tablecomp = {
    "выехал на патрулирование",
    "10%-2 как",
    "заступаю в патруль",
    "заступил в патруль",
    "выезжаю на патрулирование",
    "выхожу в патруль",
    "вышел в патруль"
  }
  local tablecompa = {
    "завершаю патруль",
    "10%-2R",
    "завершил патруль",
    "сворачиваю патруль",
    "завершаю патрулирование",
    "заканчиваю патруль",
    "завершил патрулирование"
  }
	if table_imgui[36] == "Принято" and returnchat then
    for i = 1, #tablecomp do
      if returnchat:find(tablecomp[i]) then
        local radio_disp1, radio_disp2, radio_disp3 = returnchat:match("%[R%]%s*(.*)%s%u%a*_%u%a*%[(%d*)%]%p*.+([%u]+[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?%p%d+)")
        if radio_disp1 and radio_disp2 and radio_disp3 then
          for j = table_imgui[22], table_imgui[22] do
            if radio_disp1 ~= table_imgui[j] and radio_disp2 ~= table_imgui[j+1] and radio_disp3 ~= table_imgui[j+2] and radio_disp1 ~= table_imgui[j-3] and radio_disp2 ~= table_imgui[j-2] and radio_disp3 ~= table_imgui[j-1] then
              table_imgui[j] = radio_disp1
              table_imgui[j+1] = radio_disp2 -- айди
              table_imgui[j+2] = radio_disp3 -- марк
              table_imgui[22] = table_imgui[22] + 3
            end
          end
        end
      end
    end
    for i = 1, #tablecompa do
      if returnchat:find(tablecompa[i]) then
        local disp1, disp2, disp3 = returnchat:match("%[R%]%s*(.*)%s%u%a*_%u%a*%[(%d*)%]%p*.+([%u]+[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?%p%d+)")
        if disp1 and disp2 and disp3 then
          for j = 39, 66, 3 do
            if disp1 == table_imgui[j] and disp2 == table_imgui[j+1] and disp3 == table_imgui[j+2] then
              table_imgui[j] = table_imgui[79]
              table_imgui[j+1] = table_imgui[79]
              table_imgui[j+2] = table_imgui[79]
              table_imgui[22] = 39
            end
          end
        end
      end
    end
	end
end

table_disp = {
	[1] = "---",
	[2] = "---",
	[3] = "---",
	[4] = "---",
	[5] = "---",
	[6] = "---",
	[7] = "---",
	[8] = "---",
	[9] = "---",
	[10] = "---",
	[11] = "---",
	[12] = "---",
	[13] = "---",
	[14] = "---",
	[15] = "---",
	[16] = "---",
	[17] = "---",
}

function dispetch_r()
	if table_imgui[36] == "Принято" then
		if returnchat then
			if not string.find(returnchat, ".+%b()") then
				local text_chat_disp_5, text_chat_disp_4 = string.match(returnchat, "%[R%](%s*.*%[%d*%]:)(.+)")
				::callback::
	  		if text_chat_disp_4 and not table_imgui[8] then
		  		table.insert(table_disp, 1, text_chat_disp_5 .. text_chat_disp_4)
					table_imgui[8] = true
				elseif text_chat_disp_4 and text_chat_disp_5 .. text_chat_disp_4 ~= table_disp[1] and table_imgui[8] then
					table_imgui[8] = false
				elseif text_chat_disp_4 and not table_imgui[8] and table_disp[17] ~= "---" then
				  goto callback
	  		end
			end
		end
	end
end

function clockFunc1(arg)
  if not table_imgui[233].v then
    if not result_in_chat and not dialogactive then
      if arg then
        if mainBinder[arg] ~= nil and not mainBinder[arg].enabled then
          thread_cmen:run("keys" .. arg)
        end
      end
    end
  end
end

function PatrolMenu()
  table_imgui[23].v = not table_imgui[23].v
end

function DispatchMenu()
  table_imgui[28].v = not table_imgui[28].v
end

function PostMenu()
  table_imgui[106].v = not table_imgui[106].v
end

function  AssistantMenu()
	table_imgui[20].v = not table_imgui[20].v 
end

function siren_police()
	setVirtualKeyDown(vkey.VK_H, true)
	wait(100)
	setVirtualKeyDown(vkey.VK_H, false)
	wait(200)
	setVirtualKeyDown(vkey.VK_H, true)
	wait(100)
	setVirtualKeyDown(vkey.VK_H, false)
end

function TraficMenu(id_1055)
	if id_1055 then
		arg_su = id_1055
		table_imgui[21].v = true
    sampAddChatMessage("{696969} >| {1adb6e}Убрать/показать курсор, клавиша  \"{ff692e} X {1adb6e}\".", -1)
    if table_imgui[243].v then
      sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [DISP]: провожу IO-55, нахожусь в " .. rajon() .. ", номер " .. arg_su .. " nRFR, over.")
    end
	end
end

function ComSu(arg1)
  if table_imgui[245].v then
    arg_su = arg1
    if arg_su and arg_su ~= "" then
      table_imgui[24].v = not table_imgui[24].v
    else
      sampAddChatMessage("{696969} >| {1adb6e}Не указан айди.", -1)
    end
    table_imgui[182].v = -1
    table_imgui[38].v = -1
  else
    local arg1, arg2, arg3 = arg1:match("(%d*) (%d*) (.+)")
    if arg1 and arg2 and arg3 then
      sampSendChat("/su  " .. arg1 .. " " .. arg2 .. " " .. arg3)
      threads_command:run(11)
    end
  end
end

function ComTicket(arg2)
  if table_imgui[245].v then
    arg_su = arg2
    if arg_su and arg_su ~= "" then
      table_imgui[24].v = not table_imgui[24].v
    else
      sampAddChatMessage("{696969} >| {1adb6e}Не указан айди.", -1)
    end
    table_imgui[38].v = -1
    table_imgui[182].v = -1
  else
    local arg1, arg2, arg3 = arg2:match("(%d*) (%d*) (.+)")
    if arg1 and arg2 and arg3 then
      sampSendChat("/ticket  " .. arg1 .. " " .. arg2 .. " " .. arg3)
      threads_command:run(12)
    end
  end
end

function DepartmentMenu(args)
	if args == "" then
		table_imgui[27].v = not table_imgui[27].v
	elseif args ~= "" and table_imgui[33] ~= "" then
		sampSendChat("/d [" .. u8:decode(mainSetting.setting[9]) .. "] - [" .. u8:decode(table_imgui[33]) .. "]: " .. args)
	end
end

function get_clock(time)
	local timezone_offset = 86400 - os.date('%H', 0) * 3600
	if tonumber(time) >= 86400 then onDay = true else onDay = false end
	return os.date((onDay and math.floor(time / 86400)..'д ' or '')..'%H:%M', time + timezone_offset)
end

function get_clock_pat(time)
	local timezone_offset = 86400 - os.date('%H', 0) * 3600
	-- if tonumber(time) >= 86400 then onDay = true else onDay = false end
	return os.date('%H:%M', time + timezone_offset)
end

function getClosestPlayerId()
  local minDist = 9999
  local x, y, z = getCharCoordinates(PLAYER_PED) -- мои координаты
  for i = 0, 999 do
    local streamed, pedID = sampGetCharHandleBySampPlayerId(i) -- пед игроков по иду
    if streamed then
      local xi, yi, zi = getCharCoordinates(pedID) -- коорднинаты игроков
      local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
      local result1 = isCharInAnyCar(pedID)
      local color_nick = sampGetPlayerColor(i)
      if dist < minDist and result1 and color_nick ~= 2147502591 then
				minDist = dist
				local vehcar = storeCarCharIsInNoSave(pedID)
				if vehcar then
          local ped_cars = getDriverOfCar(vehcar)
          if ped_cars then
            local bresult, id_pl = sampGetPlayerIdByCharHandle(ped_cars)
            if bresult then
              table_imgui[1] = id_pl
            end
          end
        end
      end
    end
  end
  return table_imgui[1]
end

function calculateZone(x, y, z)
	local streets = {
		{"Avispa Country Club", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169},
		{"Easter Bay Airport", -1315.420, -405.388, 15.406, -1264.400, -209.543, 25.406},
		{"Avispa Country Club", -2550.040, -355.493, 0.000, -2470.040, -318.493, 39.700},
		{"Easter Bay Airport", -1490.330, -209.543, 15.406, -1264.400, -148.388, 25.406},
		{"Garcia", -2395.140, -222.589, -5.3, -2354.090, -204.792, 200.000},
		{"Shady Cabin", -1632.830, -2263.440, -3.0, -1601.330, -2231.790, 200.000},
		{"East Los Santos", 2381.680, -1494.030, -89.084, 2421.030, -1454.350, 110.916},
		{"LVA Freight Depot", 1236.630, 1163.410, -89.084, 1277.050, 1203.280, 110.916},
		{"Blackfield Intersection", 1277.050, 1044.690, -89.084, 1315.350, 1087.630, 110.916},
		{"Avispa Country Club", -2470.040, -355.493, 0.000, -2270.040, -318.493, 46.100},
		{"Temple", 1252.330, -926.999, -89.084, 1357.000, -910.170, 110.916},
		{"Unity Station", 1692.620, -1971.800, -20.492, 1812.620, -1932.800, 79.508},
		{"LVA Freight Depot", 1315.350, 1044.690, -89.084, 1375.600, 1087.630, 110.916},
		{"Los Flores", 2581.730, -1454.350, -89.084, 2632.830, -1393.420, 110.916},
		{"Starfish Casino", 2437.390, 1858.100, -39.084, 2495.090, 1970.850, 60.916},
		{"Easter Bay Chemicals", -1132.820, -787.391, 0.000, -956.476, -768.027, 200.000},
		{"Downtown Los Santos", 1370.850, -1170.870, -89.084, 1463.900, -1130.850, 110.916},
		{"Esplanade East", -1620.300, 1176.520, -4.5, -1580.010, 1274.260, 200.000},
		{"Market Station", 787.461, -1410.930, -34.126, 866.009, -1310.210, 65.874},
		{"Linden Station", 2811.250, 1229.590, -39.594, 2861.250, 1407.590, 60.406},
		{"Montgomery Intersection", 1582.440, 347.457, 0.000, 1664.620, 401.750, 200.000},
		{"Frederick Bridge", 2759.250, 296.501, 0.000, 2774.250, 594.757, 200.000},
		{"Yellow Bell Station", 1377.480, 2600.430, -21.926, 1492.450, 2687.360, 78.074},
		{"Downtown Los Santos", 1507.510, -1385.210, 110.916, 1582.550, -1325.310, 335.916},
		{"Jefferson", 2185.330, -1210.740, -89.084, 2281.450, -1154.590, 110.916},
		{"Mulholland", 1318.130, -910.170, -89.084, 1357.000, -768.027, 110.916},
		{"Avispa Country Club", -2361.510, -417.199, 0.000, -2270.040, -355.493, 200.000},
		{"Jefferson", 1996.910, -1449.670, -89.084, 2056.860, -1350.720, 110.916},
		{"Julius Thruway West", 1236.630, 2142.860, -89.084, 1297.470, 2243.230, 110.916},
		{"Jefferson", 2124.660, -1494.030, -89.084, 2266.210, -1449.670, 110.916},
		{"Julius Thruway North", 1848.400, 2478.490, -89.084, 1938.800, 2553.490, 110.916},
		{"Rodeo", 422.680, -1570.200, -89.084, 466.223, -1406.050, 110.916},
		{"Cranberry Station", -2007.830, 56.306, 0.000, -1922.000, 224.782, 100.000},
		{"Downtown Los Santos", 1391.050, -1026.330, -89.084, 1463.900, -926.999, 110.916},
		{"Redsands West", 1704.590, 2243.230, -89.084, 1777.390, 2342.830, 110.916},
		{"Little Mexico", 1758.900, -1722.260, -89.084, 1812.620, -1577.590, 110.916},
		{"Blackfield Intersection", 1375.600, 823.228, -89.084, 1457.390, 919.447, 110.916},
		{"Los Santos International", 1974.630, -2394.330, -39.084, 2089.000, -2256.590, 60.916},
		{"Beacon Hill", -399.633, -1075.520, -1.489, -319.033, -977.516, 198.511},
		{"Rodeo", 334.503, -1501.950, -89.084, 422.680, -1406.050, 110.916},
		{"Richman", 225.165, -1369.620, -89.084, 334.503, -1292.070, 110.916},
		{"Downtown Los Santos", 1724.760, -1250.900, -89.084, 1812.620, -1150.870, 110.916},
		{"The Strip", 2027.400, 1703.230, -89.084, 2137.400, 1783.230, 110.916},
		{"Downtown Los Santos", 1378.330, -1130.850, -89.084, 1463.900, -1026.330, 110.916},
		{"Blackfield Intersection", 1197.390, 1044.690, -89.084, 1277.050, 1163.390, 110.916},
		{"Conference Center", 1073.220, -1842.270, -89.084, 1323.900, -1804.210, 110.916},
		{"Montgomery", 1451.400, 347.457, -6.1, 1582.440, 420.802, 200.000},
		{"Foster Valley", -2270.040, -430.276, -1.2, -2178.690, -324.114, 200.000},
		{"Blackfield Chapel", 1325.600, 596.349, -89.084, 1375.600, 795.010, 110.916},
		{"Los Santos International", 2051.630, -2597.260, -39.084, 2152.450, -2394.330, 60.916},
		{"Mulholland", 1096.470, -910.170, -89.084, 1169.130, -768.027, 110.916},
		{"Yellow Bell Gol Course", 1457.460, 2723.230, -89.084, 1534.560, 2863.230, 110.916},
		{"The Strip", 2027.400, 1783.230, -89.084, 2162.390, 1863.230, 110.916},
		{"Jefferson", 2056.860, -1210.740, -89.084, 2185.330, -1126.320, 110.916},
		{"Mulholland", 952.604, -937.184, -89.084, 1096.470, -860.619, 110.916},
		{"Aldea Malvada", -1372.140, 2498.520, 0.000, -1277.590, 2615.350, 200.000},
		{"Las Colinas", 2126.860, -1126.320, -89.084, 2185.330, -934.489, 110.916},
		{"Las Colinas", 1994.330, -1100.820, -89.084, 2056.860, -920.815, 110.916},
		{"Richman", 647.557, -954.662, -89.084, 768.694, -860.619, 110.916},
		{"LVA Freight Depot", 1277.050, 1087.630, -89.084, 1375.600, 1203.280, 110.916},
		{"Julius Thruway North", 1377.390, 2433.230, -89.084, 1534.560, 2507.230, 110.916},
		{"Willowfield", 2201.820, -2095.000, -89.084, 2324.000, -1989.900, 110.916},
		{"Julius Thruway North", 1704.590, 2342.830, -89.084, 1848.400, 2433.230, 110.916},
		{"Temple", 1252.330, -1130.850, -89.084, 1378.330, -1026.330, 110.916},
		{"Little Mexico", 1701.900, -1842.270, -89.084, 1812.620, -1722.260, 110.916},
		{"Queens", -2411.220, 373.539, 0.000, -2253.540, 458.411, 200.000},
		{"Las Venturas Airport", 1515.810, 1586.400, -12.500, 1729.950, 1714.560, 87.500},
		{"Richman", 225.165, -1292.070, -89.084, 466.223, -1235.070, 110.916},
		{"Temple", 1252.330, -1026.330, -89.084, 1391.050, -926.999, 110.916},
		{"East Los Santos", 2266.260, -1494.030, -89.084, 2381.680, -1372.040, 110.916},
		{"Julius Thruway East", 2623.180, 943.235, -89.084, 2749.900, 1055.960, 110.916},
		{"Willowfield", 2541.700, -1941.400, -89.084, 2703.580, -1852.870, 110.916},
		{"Las Colinas", 2056.860, -1126.320, -89.084, 2126.860, -920.815, 110.916},
		{"Julius Thruway East", 2625.160, 2202.760, -89.084, 2685.160, 2442.550, 110.916},
		{"Rodeo", 225.165, -1501.950, -89.084, 334.503, -1369.620, 110.916},
		{"Las Brujas", -365.167, 2123.010, -3.0, -208.570, 2217.680, 200.000},
		{"Julius Thruway East", 2536.430, 2442.550, -89.084, 2685.160, 2542.550, 110.916},
		{"Rodeo", 334.503, -1406.050, -89.084, 466.223, -1292.070, 110.916},
		{"Vinewood", 647.557, -1227.280, -89.084, 787.461, -1118.280, 110.916},
		{"Rodeo", 422.680, -1684.650, -89.084, 558.099, -1570.200, 110.916},
		{"Julius Thruway North", 2498.210, 2542.550, -89.084, 2685.160, 2626.550, 110.916},
		{"Downtown Los Santos", 1724.760, -1430.870, -89.084, 1812.620, -1250.900, 110.916},
		{"Rodeo", 225.165, -1684.650, -89.084, 312.803, -1501.950, 110.916},
		{"Jefferson", 2056.860, -1449.670, -89.084, 2266.210, -1372.040, 110.916},
		{"Hampton Barns", 603.035, 264.312, 0.000, 761.994, 366.572, 200.000},
		{"Temple", 1096.470, -1130.840, -89.084, 1252.330, -1026.330, 110.916},
		{"Kincaid Bridge", -1087.930, 855.370, -89.084, -961.950, 986.281, 110.916},
		{"Verona Beach", 1046.150, -1722.260, -89.084, 1161.520, -1577.590, 110.916},
		{"Commerce", 1323.900, -1722.260, -89.084, 1440.900, -1577.590, 110.916},
		{"Mulholland", 1357.000, -926.999, -89.084, 1463.900, -768.027, 110.916},
		{"Rodeo", 466.223, -1570.200, -89.084, 558.099, -1385.070, 110.916},
		{"Mulholland", 911.802, -860.619, -89.084, 1096.470, -768.027, 110.916},
		{"Mulholland", 768.694, -954.662, -89.084, 952.604, -860.619, 110.916},
		{"Julius Thruway South", 2377.390, 788.894, -89.084, 2537.390, 897.901, 110.916},
		{"Idlewood", 1812.620, -1852.870, -89.084, 1971.660, -1742.310, 110.916},
		{"Ocean Docks", 2089.000, -2394.330, -89.084, 2201.820, -2235.840, 110.916},
		{"Commerce", 1370.850, -1577.590, -89.084, 1463.900, -1384.950, 110.916},
		{"Julius Thruway North", 2121.400, 2508.230, -89.084, 2237.400, 2663.170, 110.916},
		{"Temple", 1096.470, -1026.330, -89.084, 1252.330, -910.170, 110.916},
		{"Glen Park", 1812.620, -1449.670, -89.084, 1996.910, -1350.720, 110.916},
		{"Easter Bay Airport", -1242.980, -50.096, 0.000, -1213.910, 578.396, 200.000},
		{"Martin Bridge", -222.179, 293.324, 0.000, -122.126, 476.465, 200.000},
		{"The Strip", 2106.700, 1863.230, -89.084, 2162.390, 2202.760, 110.916},
		{"Willowfield", 2541.700, -2059.230, -89.084, 2703.580, -1941.400, 110.916},
		{"Marina", 807.922, -1577.590, -89.084, 926.922, -1416.250, 110.916},
		{"Las Venturas Airport", 1457.370, 1143.210, -89.084, 1777.400, 1203.280, 110.916},
		{"Idlewood", 1812.620, -1742.310, -89.084, 1951.660, -1602.310, 110.916},
		{"Esplanade East", -1580.010, 1025.980, -6.1, -1499.890, 1274.260, 200.000},
		{"Downtown Los Santos", 1370.850, -1384.950, -89.084, 1463.900, -1170.870, 110.916},
		{"The Mako Span", 1664.620, 401.750, 0.000, 1785.140, 567.203, 200.000},
		{"Rodeo", 312.803, -1684.650, -89.084, 422.680, -1501.950, 110.916},
		{"Pershing Square", 1440.900, -1722.260, -89.084, 1583.500, -1577.590, 110.916},
		{"Mulholland", 687.802, -860.619, -89.084, 911.802, -768.027, 110.916},
		{"Gant Bridge", -2741.070, 1490.470, -6.1, -2616.400, 1659.680, 200.000},
		{"Las Colinas", 2185.330, -1154.590, -89.084, 2281.450, -934.489, 110.916},
		{"Mulholland", 1169.130, -910.170, -89.084, 1318.130, -768.027, 110.916},
		{"Julius Thruway North", 1938.800, 2508.230, -89.084, 2121.400, 2624.230, 110.916},
		{"Commerce", 1667.960, -1577.590, -89.084, 1812.620, -1430.870, 110.916},
		{"Rodeo", 72.648, -1544.170, -89.084, 225.165, -1404.970, 110.916},
		{"Roca Escalante", 2536.430, 2202.760, -89.084, 2625.160, 2442.550, 110.916},
		{"Rodeo", 72.648, -1684.650, -89.084, 225.165, -1544.170, 110.916},
		{"Market", 952.663, -1310.210, -89.084, 1072.660, -1130.850, 110.916},
		{"Las Colinas", 2632.740, -1135.040, -89.084, 2747.740, -945.035, 110.916},
		{"Mulholland", 861.085, -674.885, -89.084, 1156.550, -600.896, 110.916},
		{"King's", -2253.540, 373.539, -9.1, -1993.280, 458.411, 200.000},
		{"Redsands East", 1848.400, 2342.830, -89.084, 2011.940, 2478.490, 110.916},
		{"Downtown", -1580.010, 744.267, -6.1, -1499.890, 1025.980, 200.000},
		{"Conference Center", 1046.150, -1804.210, -89.084, 1323.900, -1722.260, 110.916},
		{"Richman", 647.557, -1118.280, -89.084, 787.461, -954.662, 110.916},
		{"Ocean Flats", -2994.490, 277.411, -9.1, -2867.850, 458.411, 200.000},
		{"Greenglass College", 964.391, 930.890, -89.084, 1166.530, 1044.690, 110.916},
		{"Glen Park", 1812.620, -1100.820, -89.084, 1994.330, -973.380, 110.916},
		{"LVA Freight Depot", 1375.600, 919.447, -89.084, 1457.370, 1203.280, 110.916},
		{"Regular Tom", -405.770, 1712.860, -3.0, -276.719, 1892.750, 200.000},
		{"Verona Beach", 1161.520, -1722.260, -89.084, 1323.900, -1577.590, 110.916},
		{"East Los Santos", 2281.450, -1372.040, -89.084, 2381.680, -1135.040, 110.916},
		{"Caligula's Palace", 2137.400, 1703.230, -89.084, 2437.390, 1783.230, 110.916},
		{"Idlewood", 1951.660, -1742.310, -89.084, 2124.660, -1602.310, 110.916},
		{"Pilgrim", 2624.400, 1383.230, -89.084, 2685.160, 1783.230, 110.916},
		{"Idlewood", 2124.660, -1742.310, -89.084, 2222.560, -1494.030, 110.916},
		{"Queens", -2533.040, 458.411, 0.000, -2329.310, 578.396, 200.000},
		{"Downtown", -1871.720, 1176.420, -4.5, -1620.300, 1274.260, 200.000},
		{"Commerce", 1583.500, -1722.260, -89.084, 1758.900, -1577.590, 110.916},
		{"East Los Santos", 2381.680, -1454.350, -89.084, 2462.130, -1135.040, 110.916},
		{"Marina", 647.712, -1577.590, -89.084, 807.922, -1416.250, 110.916},
		{"Richman", 72.648, -1404.970, -89.084, 225.165, -1235.070, 110.916},
		{"Vinewood", 647.712, -1416.250, -89.084, 787.461, -1227.280, 110.916},
		{"East Los Santos", 2222.560, -1628.530, -89.084, 2421.030, -1494.030, 110.916},
		{"Rodeo", 558.099, -1684.650, -89.084, 647.522, -1384.930, 110.916},
		{"Easter Tunnel", -1709.710, -833.034, -1.5, -1446.010, -730.118, 200.000},
		{"Rodeo", 466.223, -1385.070, -89.084, 647.522, -1235.070, 110.916},
		{"Redsands East", 1817.390, 2202.760, -89.084, 2011.940, 2342.830, 110.916},
		{"The Clown's Pocket", 2162.390, 1783.230, -89.084, 2437.390, 1883.230, 110.916},
		{"Idlewood", 1971.660, -1852.870, -89.084, 2222.560, -1742.310, 110.916},
		{"Montgomery Intersection", 1546.650, 208.164, 0.000, 1745.830, 347.457, 200.000},
		{"Willowfield", 2089.000, -2235.840, -89.084, 2201.820, -1989.900, 110.916},
		{"Temple", 952.663, -1130.840, -89.084, 1096.470, -937.184, 110.916},
		{"Prickle Pine", 1848.400, 2553.490, -89.084, 1938.800, 2863.230, 110.916},
		{"Los Santos International", 1400.970, -2669.260, -39.084, 2189.820, -2597.260, 60.916},
		{"Garver Bridge", -1213.910, 950.022, -89.084, -1087.930, 1178.930, 110.916},
		{"Garver Bridge", -1339.890, 828.129, -89.084, -1213.910, 1057.040, 110.916},
		{"Kincaid Bridge", -1339.890, 599.218, -89.084, -1213.910, 828.129, 110.916},
		{"Kincaid Bridge", -1213.910, 721.111, -89.084, -1087.930, 950.022, 110.916},
		{"Verona Beach", 930.221, -2006.780, -89.084, 1073.220, -1804.210, 110.916},
		{"Verdant Bluffs", 1073.220, -2006.780, -89.084, 1249.620, -1842.270, 110.916},
		{"Vinewood", 787.461, -1130.840, -89.084, 952.604, -954.662, 110.916},
		{"Vinewood", 787.461, -1310.210, -89.084, 952.663, -1130.840, 110.916},
		{"Commerce", 1463.900, -1577.590, -89.084, 1667.960, -1430.870, 110.916},
		{"Market", 787.461, -1416.250, -89.084, 1072.660, -1310.210, 110.916},
		{"Rockshore West", 2377.390, 596.349, -89.084, 2537.390, 788.894, 110.916},
		{"Julius Thruway North", 2237.400, 2542.550, -89.084, 2498.210, 2663.170, 110.916},
		{"East Beach", 2632.830, -1668.130, -89.084, 2747.740, -1393.420, 110.916},
		{"Fallow Bridge", 434.341, 366.572, 0.000, 603.035, 555.680, 200.000},
		{"Willowfield", 2089.000, -1989.900, -89.084, 2324.000, -1852.870, 110.916},
		{"Chinatown", -2274.170, 578.396, -7.6, -2078.670, 744.170, 200.000},
		{"El Castillo del Diablo", -208.570, 2337.180, 0.000, 8.430, 2487.180, 200.000},
		{"Ocean Docks", 2324.000, -2145.100, -89.084, 2703.580, -2059.230, 110.916},
		{"Easter Bay Chemicals", -1132.820, -768.027, 0.000, -956.476, -578.118, 200.000},
		{"The Visage", 1817.390, 1703.230, -89.084, 2027.400, 1863.230, 110.916},
		{"Ocean Flats", -2994.490, -430.276, -1.2, -2831.890, -222.589, 200.000},
		{"Richman", 321.356, -860.619, -89.084, 687.802, -768.027, 110.916},
		{"Green Palms", 176.581, 1305.450, -3.0, 338.658, 1520.720, 200.000},
		{"Richman", 321.356, -768.027, -89.084, 700.794, -674.885, 110.916},
		{"Starfish Casino", 2162.390, 1883.230, -89.084, 2437.390, 2012.180, 110.916},
		{"East Beach", 2747.740, -1668.130, -89.084, 2959.350, -1498.620, 110.916},
		{"Jefferson", 2056.860, -1372.040, -89.084, 2281.450, -1210.740, 110.916},
		{"Downtown Los Santos", 1463.900, -1290.870, -89.084, 1724.760, -1150.870, 110.916},
		{"Downtown Los Santos", 1463.900, -1430.870, -89.084, 1724.760, -1290.870, 110.916},
		{"Garver Bridge", -1499.890, 696.442, -179.615, -1339.890, 925.353, 20.385},
		{"Julius Thruway South", 1457.390, 823.228, -89.084, 2377.390, 863.229, 110.916},
		{"East Los Santos", 2421.030, -1628.530, -89.084, 2632.830, -1454.350, 110.916},
		{"Greenglass College", 964.391, 1044.690, -89.084, 1197.390, 1203.220, 110.916},
		{"Las Colinas", 2747.740, -1120.040, -89.084, 2959.350, -945.035, 110.916},
		{"Mulholland", 737.573, -768.027, -89.084, 1142.290, -674.885, 110.916},
		{"Ocean Docks", 2201.820, -2730.880, -89.084, 2324.000, -2418.330, 110.916},
		{"East Los Santos", 2462.130, -1454.350, -89.084, 2581.730, -1135.040, 110.916},
		{"Ganton", 2222.560, -1722.330, -89.084, 2632.830, -1628.530, 110.916},
		{"Avispa Country Club", -2831.890, -430.276, -6.1, -2646.400, -222.589, 200.000},
		{"Willowfield", 1970.620, -2179.250, -89.084, 2089.000, -1852.870, 110.916},
		{"Esplanade North", -1982.320, 1274.260, -4.5, -1524.240, 1358.900, 200.000},
		{"The High Roller", 1817.390, 1283.230, -89.084, 2027.390, 1469.230, 110.916},
		{"Ocean Docks", 2201.820, -2418.330, -89.084, 2324.000, -2095.000, 110.916},
		{"Last Dime Motel", 1823.080, 596.349, -89.084, 1997.220, 823.228, 110.916},
		{"Bayside Marina", -2353.170, 2275.790, 0.000, -2153.170, 2475.790, 200.000},
		{"King's", -2329.310, 458.411, -7.6, -1993.280, 578.396, 200.000},
		{"El Corona", 1692.620, -2179.250, -89.084, 1812.620, -1842.270, 110.916},
		{"Blackfield Chapel", 1375.600, 596.349, -89.084, 1558.090, 823.228, 110.916},
		{"The Pink Swan", 1817.390, 1083.230, -89.084, 2027.390, 1283.230, 110.916},
		{"Julius Thruway West", 1197.390, 1163.390, -89.084, 1236.630, 2243.230, 110.916},
		{"Los Flores", 2581.730, -1393.420, -89.084, 2747.740, -1135.040, 110.916},
		{"The Visage", 1817.390, 1863.230, -89.084, 2106.700, 2011.830, 110.916},
		{"Prickle Pine", 1938.800, 2624.230, -89.084, 2121.400, 2861.550, 110.916},
		{"Verona Beach", 851.449, -1804.210, -89.084, 1046.150, -1577.590, 110.916},
		{"Robada Intersection", -1119.010, 1178.930, -89.084, -862.025, 1351.450, 110.916},
		{"Linden Side", 2749.900, 943.235, -89.084, 2923.390, 1198.990, 110.916},
		{"Ocean Docks", 2703.580, -2302.330, -89.084, 2959.350, -2126.900, 110.916},
		{"Willowfield", 2324.000, -2059.230, -89.084, 2541.700, -1852.870, 110.916},
		{"King's", -2411.220, 265.243, -9.1, -1993.280, 373.539, 200.000},
		{"Commerce", 1323.900, -1842.270, -89.084, 1701.900, -1722.260, 110.916},
		{"Mulholland", 1269.130, -768.027, -89.084, 1414.070, -452.425, 110.916},
		{"Marina", 647.712, -1804.210, -89.084, 851.449, -1577.590, 110.916},
		{"Battery Point", -2741.070, 1268.410, -4.5, -2533.040, 1490.470, 200.000},
		{"The Four Dragons Casino", 1817.390, 863.232, -89.084, 2027.390, 1083.230, 110.916},
		{"Blackfield", 964.391, 1203.220, -89.084, 1197.390, 1403.220, 110.916},
		{"Julius Thruway North", 1534.560, 2433.230, -89.084, 1848.400, 2583.230, 110.916},
		{"Yellow Bell Gol Course", 1117.400, 2723.230, -89.084, 1457.460, 2863.230, 110.916},
		{"Idlewood", 1812.620, -1602.310, -89.084, 2124.660, -1449.670, 110.916},
		{"Redsands West", 1297.470, 2142.860, -89.084, 1777.390, 2243.230, 110.916},
		{"Doherty", -2270.040, -324.114, -1.2, -1794.920, -222.589, 200.000},
		{"Hilltop Farm", 967.383, -450.390, -3.0, 1176.780, -217.900, 200.000},
		{"Las Barrancas", -926.130, 1398.730, -3.0, -719.234, 1634.690, 200.000},
		{"Pirates in Men's Pants", 1817.390, 1469.230, -89.084, 2027.400, 1703.230, 110.916},
		{"City Hall", -2867.850, 277.411, -9.1, -2593.440, 458.411, 200.000},
		{"Avispa Country Club", -2646.400, -355.493, 0.000, -2270.040, -222.589, 200.000},
		{"The Strip", 2027.400, 863.229, -89.084, 2087.390, 1703.230, 110.916},
		{"Hashbury", -2593.440, -222.589, -1.0, -2411.220, 54.722, 200.000},
		{"Los Santos International", 1852.000, -2394.330, -89.084, 2089.000, -2179.250, 110.916},
		{"Whitewood Estates", 1098.310, 1726.220, -89.084, 1197.390, 2243.230, 110.916},
		{"Sherman Reservoir", -789.737, 1659.680, -89.084, -599.505, 1929.410, 110.916},
		{"El Corona", 1812.620, -2179.250, -89.084, 1970.620, -1852.870, 110.916},
		{"Downtown", -1700.010, 744.267, -6.1, -1580.010, 1176.520, 200.000},
		{"Foster Valley", -2178.690, -1250.970, 0.000, -1794.920, -1115.580, 200.000},
		{"Las Payasadas", -354.332, 2580.360, 2.0, -133.625, 2816.820, 200.000},
		{"Valle Ocultado", -936.668, 2611.440, 2.0, -715.961, 2847.900, 200.000},
		{"Blackfield Intersection", 1166.530, 795.010, -89.084, 1375.600, 1044.690, 110.916},
		{"Ganton", 2222.560, -1852.870, -89.084, 2632.830, -1722.330, 110.916},
		{"Easter Bay Airport", -1213.910, -730.118, 0.000, -1132.820, -50.096, 200.000},
		{"Redsands East", 1817.390, 2011.830, -89.084, 2106.700, 2202.760, 110.916},
		{"Esplanade East", -1499.890, 578.396, -79.615, -1339.890, 1274.260, 20.385},
		{"Caligula's Palace", 2087.390, 1543.230, -89.084, 2437.390, 1703.230, 110.916},
		{"Royal Casino", 2087.390, 1383.230, -89.084, 2437.390, 1543.230, 110.916},
		{"Richman", 72.648, -1235.070, -89.084, 321.356, -1008.150, 110.916},
		{"Starfish Casino", 2437.390, 1783.230, -89.084, 2685.160, 2012.180, 110.916},
		{"Mulholland", 1281.130, -452.425, -89.084, 1641.130, -290.913, 110.916},
		{"Downtown", -1982.320, 744.170, -6.1, -1871.720, 1274.260, 200.000},
		{"Hankypanky Point", 2576.920, 62.158, 0.000, 2759.250, 385.503, 200.000},
		{"K.A.C.C. Military Fuels", 2498.210, 2626.550, -89.084, 2749.900, 2861.550, 110.916},
		{"Harry Gold Parkway", 1777.390, 863.232, -89.084, 1817.390, 2342.830, 110.916},
		{"Bayside Tunnel", -2290.190, 2548.290, -89.084, -1950.190, 2723.290, 110.916},
		{"Ocean Docks", 2324.000, -2302.330, -89.084, 2703.580, -2145.100, 110.916},
		{"Richman", 321.356, -1044.070, -89.084, 647.557, -860.619, 110.916},
		{"Randolph Industrial Estate", 1558.090, 596.349, -89.084, 1823.080, 823.235, 110.916},
		{"East Beach", 2632.830, -1852.870, -89.084, 2959.350, -1668.130, 110.916},
		{"Flint Water", -314.426, -753.874, -89.084, -106.339, -463.073, 110.916},
		{"Blueberry", 19.607, -404.136, 3.8, 349.607, -220.137, 200.000},
		{"Linden Station", 2749.900, 1198.990, -89.084, 2923.390, 1548.990, 110.916},
		{"Glen Park", 1812.620, -1350.720, -89.084, 2056.860, -1100.820, 110.916},
		{"Downtown", -1993.280, 265.243, -9.1, -1794.920, 578.396, 200.000},
		{"Redsands West", 1377.390, 2243.230, -89.084, 1704.590, 2433.230, 110.916},
		{"Richman", 321.356, -1235.070, -89.084, 647.522, -1044.070, 110.916},
		{"Gant Bridge", -2741.450, 1659.680, -6.1, -2616.400, 2175.150, 200.000},
		{"Lil' Probe Inn", -90.218, 1286.850, -3.0, 153.859, 1554.120, 200.000},
		{"Flint Intersection", -187.700, -1596.760, -89.084, 17.063, -1276.600, 110.916},
		{"Las Colinas", 2281.450, -1135.040, -89.084, 2632.740, -945.035, 110.916},
		{"Sobell Rail Yards", 2749.900, 1548.990, -89.084, 2923.390, 1937.250, 110.916},
		{"The Emerald Isle", 2011.940, 2202.760, -89.084, 2237.400, 2508.230, 110.916},
		{"El Castillo del Diablo", -208.570, 2123.010, -7.6, 114.033, 2337.180, 200.000},
		{"Santa Flora", -2741.070, 458.411, -7.6, -2533.040, 793.411, 200.000},
		{"Playa del Seville", 2703.580, -2126.900, -89.084, 2959.350, -1852.870, 110.916},
		{"Market", 926.922, -1577.590, -89.084, 1370.850, -1416.250, 110.916},
		{"Queens", -2593.440, 54.722, 0.000, -2411.220, 458.411, 200.000},
		{"Pilson Intersection", 1098.390, 2243.230, -89.084, 1377.390, 2507.230, 110.916},
		{"Spinybed", 2121.400, 2663.170, -89.084, 2498.210, 2861.550, 110.916},
		{"Pilgrim", 2437.390, 1383.230, -89.084, 2624.400, 1783.230, 110.916},
		{"Blackfield", 964.391, 1403.220, -89.084, 1197.390, 1726.220, 110.916},
		{"The Big Ear", -410.020, 1403.340, -3.0, -137.969, 1681.230, 200.000},
		{"Dillimore", 580.794, -674.885, -9.5, 861.085, -404.790, 200.000},
		{"El Quebrados", -1645.230, 2498.520, 0.000, -1372.140, 2777.850, 200.000},
		{"Esplanade North", -2533.040, 1358.900, -4.5, -1996.660, 1501.210, 200.000},
		{"Easter Bay Airport", -1499.890, -50.096, -1.0, -1242.980, 249.904, 200.000},
		{"Fisher's Lagoon", 1916.990, -233.323, -100.000, 2131.720, 13.800, 200.000},
		{"Mulholland", 1414.070, -768.027, -89.084, 1667.610, -452.425, 110.916},
		{"East Beach", 2747.740, -1498.620, -89.084, 2959.350, -1120.040, 110.916},
		{"San Andreas Sound", 2450.390, 385.503, -100.000, 2759.250, 562.349, 200.000},
		{"Shady Creeks", -2030.120, -2174.890, -6.1, -1820.640, -1771.660, 200.000},
		{"Market", 1072.660, -1416.250, -89.084, 1370.850, -1130.850, 110.916},
		{"Rockshore West", 1997.220, 596.349, -89.084, 2377.390, 823.228, 110.916},
		{"Prickle Pine", 1534.560, 2583.230, -89.084, 1848.400, 2863.230, 110.916},
		{"Easter Basin", -1794.920, -50.096, -1.04, -1499.890, 249.904, 200.000},
		{"Leafy Hollow", -1166.970, -1856.030, 0.000, -815.624, -1602.070, 200.000},
		{"LVA Freight Depot", 1457.390, 863.229, -89.084, 1777.400, 1143.210, 110.916},
		{"Prickle Pine", 1117.400, 2507.230, -89.084, 1534.560, 2723.230, 110.916},
		{"Blueberry", 104.534, -220.137, 2.3, 349.607, 152.236, 200.000},
		{"El Castillo del Diablo", -464.515, 2217.680, 0.000, -208.570, 2580.360, 200.000},
		{"Downtown", -2078.670, 578.396, -7.6, -1499.890, 744.267, 200.000},
		{"Rockshore East", 2537.390, 676.549, -89.084, 2902.350, 943.235, 110.916},
		{"San Fierro Bay", -2616.400, 1501.210, -3.0, -1996.660, 1659.680, 200.000},
		{"Paradiso", -2741.070, 793.411, -6.1, -2533.040, 1268.410, 200.000},
		{"The Camel's Toe", 2087.390, 1203.230, -89.084, 2640.400, 1383.230, 110.916},
		{"Old Venturas Strip", 2162.390, 2012.180, -89.084, 2685.160, 2202.760, 110.916},
		{"Juniper Hill", -2533.040, 578.396, -7.6, -2274.170, 968.369, 200.000},
		{"Juniper Hollow", -2533.040, 968.369, -6.1, -2274.170, 1358.900, 200.000},
		{"Roca Escalante", 2237.400, 2202.760, -89.084, 2536.430, 2542.550, 110.916},
		{"Julius Thruway East", 2685.160, 1055.960, -89.084, 2749.900, 2626.550, 110.916},
		{"Verona Beach", 647.712, -2173.290, -89.084, 930.221, -1804.210, 110.916},
		{"Foster Valley", -2178.690, -599.884, -1.2, -1794.920, -324.114, 200.000},
		{"Arco del Oeste", -901.129, 2221.860, 0.000, -592.090, 2571.970, 200.000},
		{"Fallen Tree", -792.254, -698.555, -5.3, -452.404, -380.043, 200.000},
		{"The Farm", -1209.670, -1317.100, 114.981, -908.161, -787.391, 251.981},
		{"The Sherman Dam", -968.772, 1929.410, -3.0, -481.126, 2155.260, 200.000},
		{"Esplanade North", -1996.660, 1358.900, -4.5, -1524.240, 1592.510, 200.000},
		{"Financial", -1871.720, 744.170, -6.1, -1701.300, 1176.420, 300.000},
		{"Garcia", -2411.220, -222.589, -1.14, -2173.040, 265.243, 200.000},
		{"Montgomery", 1119.510, 119.526, -3.0, 1451.400, 493.323, 200.000},
		{"Creek", 2749.900, 1937.250, -89.084, 2921.620, 2669.790, 110.916},
		{"Los Santos International", 1249.620, -2394.330, -89.084, 1852.000, -2179.250, 110.916},
		{"Santa Maria Beach", 72.648, -2173.290, -89.084, 342.648, -1684.650, 110.916},
		{"Mulholland Intersection", 1463.900, -1150.870, -89.084, 1812.620, -768.027, 110.916},
		{"Angel Pine", -2324.940, -2584.290, -6.1, -1964.220, -2212.110, 200.000},
		{"Verdant Meadows", 37.032, 2337.180, -3.0, 435.988, 2677.900, 200.000},
		{"Octane Springs", 338.658, 1228.510, 0.000, 664.308, 1655.050, 200.000},
		{"Come-A-Lot", 2087.390, 943.235, -89.084, 2623.180, 1203.230, 110.916},
		{"Redsands West", 1236.630, 1883.110, -89.084, 1777.390, 2142.860, 110.916},
		{"Santa Maria Beach", 342.648, -2173.290, -89.084, 647.712, -1684.650, 110.916},
		{"Verdant Bluffs", 1249.620, -2179.250, -89.084, 1692.620, -1842.270, 110.916},
		{"Las Venturas Airport", 1236.630, 1203.280, -89.084, 1457.370, 1883.110, 110.916},
		{"Flint Range", -594.191, -1648.550, 0.000, -187.700, -1276.600, 200.000},
		{"Verdant Bluffs", 930.221, -2488.420, -89.084, 1249.620, -2006.780, 110.916},
		{"Palomino Creek", 2160.220, -149.004, 0.000, 2576.920, 228.322, 200.000},
		{"Ocean Docks", 2373.770, -2697.090, -89.084, 2809.220, -2330.460, 110.916},
		{"Easter Bay Airport", -1213.910, -50.096, -4.5, -947.980, 578.396, 200.000},
		{"Whitewood Estates", 883.308, 1726.220, -89.084, 1098.310, 2507.230, 110.916},
		{"Calton Heights", -2274.170, 744.170, -6.1, -1982.320, 1358.900, 200.000},
		{"Easter Basin", -1794.920, 249.904, -9.1, -1242.980, 578.396, 200.000},
		{"Los Santos Inlet", -321.744, -2224.430, -89.084, 44.615, -1724.430, 110.916},
		{"Doherty", -2173.040, -222.589, -1.0, -1794.920, 265.243, 200.000},
		{"Mount Chiliad", -2178.690, -2189.910, -47.917, -2030.120, -1771.660, 576.083},
		{"Fort Carson", -376.233, 826.326, -3.0, 123.717, 1220.440, 200.000},
		{"Foster Valley", -2178.690, -1115.580, 0.000, -1794.920, -599.884, 200.000},
		{"Ocean Flats", -2994.490, -222.589, -1.0, -2593.440, 277.411, 200.000},
		{"Fern Ridge", 508.189, -139.259, 0.000, 1306.660, 119.526, 200.000},
		{"Bayside", -2741.070, 2175.150, 0.000, -2353.170, 2722.790, 200.000},
		{"Las Venturas Airport", 1457.370, 1203.280, -89.084, 1777.390, 1883.110, 110.916},
		{"Blueberry Acres", -319.676, -220.137, 0.000, 104.534, 293.324, 200.000},
		{"Palisades", -2994.490, 458.411, -6.1, -2741.070, 1339.610, 200.000},
		{"North Rock", 2285.370, -768.027, 0.000, 2770.590, -269.740, 200.000},
		{"Hunter Quarry", 337.244, 710.840, -115.239, 860.554, 1031.710, 203.761},
		{"Los Santos International", 1382.730, -2730.880, -89.084, 2201.820, -2394.330, 110.916},
		{"Missionary Hill", -2994.490, -811.276, 0.000, -2178.690, -430.276, 200.000},
		{"San Fierro Bay", -2616.400, 1659.680, -3.0, -1996.660, 2175.150, 200.000},
		{"Restricted Area", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000},
		{"Mount Chiliad", -2997.470, -1115.580, -47.917, -2178.690, -971.913, 576.083},
		{"Mount Chiliad", -2178.690, -1771.660, -47.917, -1936.120, -1250.970, 576.083},
		{"Easter Bay Airport", -1794.920, -730.118, -3.0, -1213.910, -50.096, 200.000},
		{"The Panopticon", -947.980, -304.320, -1.1, -319.676, 327.071, 200.000},
		{"Shady Creeks", -1820.640, -2643.680, -8.0, -1226.780, -1771.660, 200.000},
		{"Back o Beyond", -1166.970, -2641.190, 0.000, -321.744, -1856.030, 200.000},
		{"Mount Chiliad", -2994.490, -2189.910, -47.917, -2178.690, -1115.580, 576.083},
		{"Tierra Robada", -1213.910, 596.349, -242.990, -480.539, 1659.680, 900.000},
		{"Flint County", -1213.910, -2892.970, -242.990, 44.615, -768.027, 900.000},
		{"Whetstone", -2997.470, -2892.970, -242.990, -1213.910, -1115.580, 900.000},
		{"Bone County", -480.539, 478.000, -242.990, 869.461, 2993.870, 900.000},
		{"Tierra Robada", -2997.470, 1659.680, -242.990, -480.539, 2993.870, 900.000},
		{"San Fierro", -2997.470, -1115.580, -242.990, -1213.910, 1659.680, 900.000},
		{"Las Venturas", 869.461, 596.349, -242.990, 2997.060, 2993.870, 900.000},
		{"Red County", -1213.910, -768.027, -242.990, 2997.060, 478.000, 900.000},
		{"Los Santos", 44.615, -2892.970, -242.990, 2997.060, -768.027, 900.000}
	}
	for i, v in ipairs(streets) do
		if (x >= v[2]) and (y >= v[3]) and (z >= v[4]) and (x <= v[5]) and (y <= v[6]) and (z <= v[7]) then
			return v[1]
    end
  end
    return 'Неизвестно'
end

function kvadrat()
	local KV = {
		[1] = "А",
		[2] = "Б",
		[3] = "В",
		[4] = "Г",
		[5] = "Д",
		[6] = "Ж",
		[7] = "З",
		[8] = "И",
		[9] = "К",
		[10] = "Л",
		[11] = "М",
		[12] = "Н",
		[13] = "О",
		[14] = "П",
		[15] = "Р",
		[16] = "С",
		[17] = "Т",
		[18] = "У",
		[19] = "Ф",
		[20] = "Х",
		[21] = "Ц",
		[22] = "Ч",
		[23] = "Ш",
		[24] = "Я",
	}
	local X, Y, Z = getCharCoordinates(PLAYER_PED)
	X = math.ceil((X + 3000) / 250)
	Y = math.ceil((Y * - 1 + 3000) / 250)
	Y = KV[Y]
	local KVX = (Y.."-"..X)
	return KVX
end

function rajon()
	local x, y, z = getCharCoordinates(PLAYER_PED)
	return calculateZone(x, y, z)
end

function imgui.OnDrawFrame() -- имгуи

	if table_imgui[177].v then --piemenu
    if table_imgui[190].v then
      imgui.OpenPopup('PieMenu')
      imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.28, 0.28, 0.28, 0.55))
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.05, 0.06, 0.05, 0.60))
          if pie.BeginPiePopup('PieMenu', 2) then
            for i = 1, 6 do
              if pie.BeginPieMenu(main_pie_section[i]) then
                local m = i .. 0
                local n = m - 9
                for j = n, m do
                  if pie.BeginPieMenu(u8:decode(mainBind[j].name)) then
                    table_imgui[176] = table_imgui[163] -- true
                    if table_imgui[176] and imgui.IsMouseClicked(0) then
                        if mainBind[j] ~= nil then
                          thread_cmen:run("bind" .. j)
                        end
                      table_imgui[176] = table_imgui[162] --false
                      table_imgui[177].v = table_imgui[162]
                    end
                    pie.EndPieMenu()
                  end
                end
                pie.EndPieMenu()
              end
            end
            pie.EndPiePopup()
          end
        imgui.PopStyleColor()
      imgui.PopStyleColor()
    end
	end

	if table_imgui[20].v then --главное окно
    -- table_imgui[14] = true
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(0.5, 0.5))
		if table_imgui[219] then imgui.SetNextWindowSize(imgui.ImVec2(800, 600), imgui.Cond.Always) end
    if not table_imgui[219] then imgui.SetNextWindowSize(imgui.ImVec2(800, 800), imgui.Cond.Always) end
		imgui.Begin("                                                                                              YOUR ASSISTENT", table_imgui[20], imgui.WindowFlags.NoResize)
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.27, 0.46, 1.71, 0.60))
      imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.27, 0.46, 1.71, 0.90))
        imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 5)

          if imgui.Button(u8" ОСНОВНЫЕ\nНАСТРОЙКИ", imgui.ImVec2(150, 80)) then
            table_imgui[8] = not table_imgui[8]
            table_imgui[238] = table_imgui[162]
          end

          imgui.SameLine()

          if imgui.Button(u8"НАСТРОЙКИ\n      ЧАТА", imgui.ImVec2(150, 80)) then
            table_imgui[238] = not table_imgui[238]
            table_imgui[8] = table_imgui[162]
          end

          imgui.SameLine()

          imgui.Button(u8"МАГАЗИН", imgui.ImVec2(150, 80))

          imgui.SameLine()

          imgui.Button(u8"ПЕРЕЗАГРУЗИТЬ", imgui.ImVec2(150, 80))

          imgui.SameLine()

          imgui.Button(u8"ОТКЛЮЧИТЬ", imgui.ImVec2(150, 80))
        imgui.PopStyleVar()

        imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.20))
          imgui.Separator()
        imgui.PopStyleColor()

        if not table_imgui[8] and not table_imgui[238] then
          imgui.SetCursorPos(imgui.ImVec2(300, 250))
          imgui.Image(img1, imgui.ImVec2(200, 200), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), imgui.ImVec4(1, 1, 1, 0.4))
        end

        if table_imgui[8] then -- окно патруля
          imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 2)
            if imgui.Button(u8"Патруля", imgui.ImVec2(105, 20)) then
              table_imgui[12] = not table_imgui[12]
              table_imgui[113] = table_imgui[162]
              table_imgui[13] = table_imgui[162]
              table_imgui[14] = table_imgui[162]
              table_imgui[11] = table_imgui[162]
              table_imgui[179] = table_imgui[162]
              table_imgui[220] = table_imgui[162]
            end
            imgui.SameLine()
            if imgui.Button(u8"Диспетчера", imgui.ImVec2(105, 20)) then
              table_imgui[13] = not table_imgui[13]
              table_imgui[113] = table_imgui[162]
              table_imgui[12] = table_imgui[162]
              table_imgui[14] = table_imgui[162]
              table_imgui[11] = table_imgui[162]
              table_imgui[179] = table_imgui[162]
              table_imgui[220] = table_imgui[162]
            end
            imgui.SameLine()
            if imgui.Button(u8"Департамента", imgui.ImVec2(105, 20)) then
              table_imgui[84].v = ""
              table_imgui[14] = not table_imgui[14]
              table_imgui[113] = table_imgui[162]
              table_imgui[13] = table_imgui[162]
              table_imgui[12] = table_imgui[162]
              table_imgui[11] = table_imgui[162]
              table_imgui[179] = table_imgui[162]
              table_imgui[220] = table_imgui[162]
            end
            imgui.SameLine()
            if imgui.Button(u8"Биндера", imgui.ImVec2(105, 20)) then
              table_imgui[11] = not table_imgui[11]
              table_imgui[113] = table_imgui[162]
              table_imgui[12] = table_imgui[162]
              table_imgui[13] = table_imgui[162]
              table_imgui[14] = table_imgui[162]
              table_imgui[179] = table_imgui[162]
              table_imgui[220] = table_imgui[162]
            end
            imgui.SameLine()
            if imgui.Button(u8"Оружия", imgui.ImVec2(105, 20)) then
              table_imgui[113] = not table_imgui[113]
              table_imgui[11] = table_imgui[162]
              table_imgui[12] = table_imgui[162]
              table_imgui[13] = table_imgui[162]
              table_imgui[14] = table_imgui[162]
              table_imgui[179] = table_imgui[162]
              table_imgui[220] = table_imgui[162]
            end
            imgui.SameLine()
            if imgui.Button(u8"Кругового меню", imgui.ImVec2(105, 20)) then
              table_imgui[179] = not table_imgui[179]
              table_imgui[11] = table_imgui[162]
              table_imgui[12] = table_imgui[162]
              table_imgui[13] = table_imgui[162]
              table_imgui[14] = table_imgui[162]
              table_imgui[113] = table_imgui[162]
              table_imgui[220] = table_imgui[162]
            end
            imgui.SameLine()
            if imgui.Button(u8"Собеседования", imgui.ImVec2(106, 20)) then
              table_imgui[220] = not table_imgui[220]
              table_imgui[11] = table_imgui[162]
              table_imgui[12] = table_imgui[162]
              table_imgui[13] = table_imgui[162]
              table_imgui[14] = table_imgui[162]
              table_imgui[113] = table_imgui[162]
              table_imgui[179] = table_imgui[162]
            end
          imgui.PopStyleVar()
        else
          table_imgui[179] = table_imgui[162]
          table_imgui[11] = table_imgui[162]
          table_imgui[12] = table_imgui[162]
          table_imgui[13] = table_imgui[162]
          table_imgui[14] = table_imgui[162]
          table_imgui[113] = table_imgui[162]
          table_imgui[220] = table_imgui[162]
        end
        imgui.PopStyleColor()
      imgui.PopStyleColor()

      if table_imgui[238] then

        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
            imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)

              imgui.BeginChild("###52", imgui.ImVec2(784, 479), true)

              imgui.Text(u8(returnchat))

              imgui.EndChild()

            imgui.PopStyleVar()
          imgui.PopStyleColor()
        imgui.PopStyleVar()
      end
      
      if table_imgui[12] then -- патруль

        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
            imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
              imgui.BeginChild("###02", imgui.ImVec2(784, 456), true)

              imgui.SetCursorPos(imgui.ImVec2(6, 6))
              imgui.BeginChild("###41", imgui.ImVec2(264, 444), true)

                imgui.TextColored(imgui.ImVec4(0.00, 1.02, 0.14, 1.0), u8"Никнейм:")
                imgui.SameLine()
                imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.50), u8"без _")
                imgui.PushItemWidth(170)
                imgui.InputText(u8"##0001", table_imgui[17])
                imgui.SameLine()
                if imgui.Button(u8"Сохранить##1") and table_imgui[17].v ~= "" then
                  mainSetting.setting[1] = u8(table_imgui[17].v)
                  if inicfg.save(mainSetting, "moonloader\\config\\setting.ini") then
                    sampAddChatMessage("{696969} >| {1adb6e}Ник успешно сохранен.", -1)
                  end
                end

                imgui.TextColored(imgui.ImVec4(0.00, 1.02, 0.14, 1.0), u8"Звание:")
                imgui.SameLine()
                imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.50), u8"можно сокращенно")
                imgui.InputText(u8"##0002", table_imgui[18])
                imgui.SameLine()
                if imgui.Button(u8"Сохранить##2") and table_imgui[18].v ~= "" then
                  mainSetting.setting[2] = u8(table_imgui[18].v)
                  if inicfg.save(mainSetting, "moonloader\\config\\setting.ini") then
                    sampAddChatMessage("{696969} >| {1adb6e}Звание успешно сохранено.", -1)
                  end
                end

                imgui.TextColored(imgui.ImVec4(0.00, 1.02, 0.14, 1.0), u8"Номер телефона:")
                imgui.InputText(u8"##0017", table_imgui[242])
                imgui.SameLine()
                if imgui.Button(u8"Сохранить##3") and table_imgui[242].v ~= "" then
                  mainSetting.setting[3] = table_imgui[242].v
                  if inicfg.save(mainSetting, "moonloader\\config\\setting.ini") then
                    sampAddChatMessage("{696969} >| {1adb6e}Номер телефона успешно сохранен.", -1)
                  end
                end

              imgui.EndChild()

              imgui.SameLine()
              imgui.SetCursorPosX(275)
              imgui.BeginChild("###42", imgui.ImVec2(503, 444), true)
                
                imgui.SameLine()
                if imgui.Checkbox("###18", table_imgui[243]) then
                  if table_imgui[243].v or not table_imgui[243].v then
                    mainSetting.setting[4] = table_imgui[243].v 
                    inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
                  end
                end
                imgui.SameLine()
                imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.95), u8"Доклад в рацию при открытии окна \"МЕНЮ 10-55\"")

                imgui.SetCursorPos(imgui.ImVec2(16, 35))
                if imgui.Checkbox("###19", table_imgui[244]) then
                  if table_imgui[244].v or not table_imgui[244].v then
                    mainSetting.setting[5] = table_imgui[244].v
                    inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
                  end
                end
                imgui.SameLine()
                imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.95), u8"Доклад в рацию при нажатии кпонки \"Завершить\" (МЕНЮ 10-55)")

                imgui.SetCursorPos(imgui.ImVec2(16, 62))
                if imgui.Checkbox("###21", table_imgui[245]) then
                  if table_imgui[245].v or not table_imgui[245].v then
                    mainSetting.setting[6] = table_imgui[245].v
                    inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
                  end
                end
                imgui.SameLine()
                imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.95), u8"Модифицированное меню Уголовного и Административного Кодекса")

                imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(2.19, 2.19, 2.19, 0.40))
                imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(2.19, 2.19, 2.19, 0.40)) 
                imgui.SetCursorPos(imgui.ImVec2(179, 88))
                imgui.BeginChild("###18", imgui.ImVec2(146, 27), true)
      
                imgui.SetCursorPos(imgui.ImVec2(7, 7))
                imgui.Text(u8"СЕРВЕРНЫЕ КОМАНДЫ")
      
                imgui.EndChild()
                imgui.PopStyleColor()
                imgui.PopStyleColor()

                imgui.SetCursorPos(imgui.ImVec2(5, 115))
                imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.50))
                  imgui.Separator()
                imgui.PopStyleColor()

                imgui.Columns(3, "015", true)
                for i = 1, 36 do

                  imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.25, 0.25, 0.35, 0.30))
                  imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.15, 0.15, 0.15, 0.85))
                  imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.25, 0.25, 0.25, 0.90))
                  imgui.Button("" .. NameCommandRp[i], imgui.ImVec2(123, 23))
                  imgui.PopStyleColor()
                  imgui.PopStyleColor()
                  imgui.PopStyleColor()

                  imgui.SameLine()
                  if imgui.Checkbox("###22" .. i, CheckboxButtonRp[i]) then
                    table_imgui[246] = i
                    if CheckboxButtonRp[table_imgui[246]].v or not CheckboxButtonRp[table_imgui[246]].v then
                      mainCommand[table_imgui[246]].enabled = CheckboxButtonRp[table_imgui[246]].v
                      inicfg.save(mainCommand, "moonloader\\config\\commandrp.ini")
                    end
                  end
                  if i == 12 or i == 24 then
                    imgui.NextColumn()
                  end
                end
                imgui.Columns(1)

              imgui.EndChild()

              imgui.EndChild()
            imgui.PopStyleVar()
          imgui.PopStyleColor()
        imgui.PopStyleVar()

      elseif table_imgui[11] then -- биндер
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
            imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)

              imgui.SetCursorPosY(138)
              imgui.BeginChild("###03", imgui.ImVec2(784, 456), true)
                
                if imgui.Checkbox("###16", table_imgui[233]) then
                  if table_imgui[233].v or not table_imgui[233].v then
                    mainSetting.setting[14] = table_imgui[233].v
                    inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
                  end
                end

                imgui.SameLine()
                
                imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"Отключить все бинды")

                imgui.SetCursorPosY(32)
                imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.30))   
                imgui.Separator()

                imgui.Columns(2, "001", true)

                imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 1.00))
                  imgui.PushStyleColor(imgui.Col.FrameBgHovered, imgui.ImVec4(0.15, 0.15, 0.15, 0.85))
                    imgui.PushStyleColor(imgui.Col.FrameBgActive, imgui.ImVec4(0.25, 0.25, 0.25, 0.90))

                      imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 1.58, 0.34, 0.25))
                        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.15, 0.15, 0.15, 0.85))
                          imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.25, 0.25, 0.25, 0.90))
                          for i = 1, 24 do
                            if imgui.Button(u8"" .. mainBinder[i].name, imgui.ImVec2(377, 22)) then
                              table_imgui[232].v = ""
                              table_imgui[236] = i
                              table_imgui[234].v = mainBinder[i].name .. ""
                              if table_imgui[236] ~= nil then
                                table_imgui[235].v = mainBinder[table_imgui[236]].wait .. ""
                                table_imgui[237].v = mainBinder[table_imgui[236]].enabled 
                                for j = 1, 30 do
                                  if mainBinder[table_imgui[236]][j] then
                                    table_imgui[232].v = table_imgui[232].v .. mainBinder[table_imgui[236]][j] .. "\n"
                                  end
                                end
                              else
                                table_imgui[232].v = ""
                              end
                            end
                            if i == 12 then
                              imgui.NextColumn()
                            end
                          end
                          imgui.Columns(1)

                          imgui.SetCursorPosY(348)
                          imgui.Separator()
                          imgui.PopStyleColor()

                          imgui.PopStyleColor()
                        imgui.PopStyleColor()
                      imgui.PopStyleColor()

                    imgui.PopStyleColor()
                  imgui.PopStyleColor()
                imgui.PopStyleColor()

                imgui.PushItemWidth(130)
                imgui.SetCursorPos(imgui.ImVec2(7, 357))
                imgui.InputText("##0003", table_imgui[234])

                imgui.SameLine()

                imgui.TextColored(imgui.ImVec4(0.90, 0.90, 0.90, 0.70), u8"Название")

                imgui.SameLine()

                imgui.PushItemWidth(50)
                imgui.SetCursorPosX(220)
                imgui.InputText("##0004", table_imgui[235])

                imgui.SameLine()

                imgui.TextColored(imgui.ImVec4(0.90, 0.90, 0.90, 0.70), u8"Задержка")

                imgui.SameLine()

                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.20, 0.24, 0.23, 1.00))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.30, 0.34, 0.33, 1.00))
                imgui.SetCursorPos(imgui.ImVec2(395, 355))
                if imgui.Button(u8"Теги", imgui.ImVec2(65, 24)) then
                  table_imgui[219] = not table_imgui[219]
                end
                imgui.PopStyleColor()
                imgui.PopStyleColor()

                imgui.SetCursorPos(imgui.ImVec2(7, 386))
                imgui.InputTextMultiline(u8"##0006", table_imgui[232], imgui.ImVec2(514, 62))

                imgui.SameLine()

                imgui.SetCursorPos(imgui.ImVec2(527, 355))
                imgui.BeginChild("###04", imgui.ImVec2(251, 94), true)

                  imgui.SetCursorPos(imgui.ImVec2(3, 5))
                  if table_imgui[236] ~= "" then
                    if imgui.HotKey("###00 " .. table_imgui[236], table_binder[table_imgui[236]], tLastKeys, 246) then
                      rkeys.changeHotKey(mass_bind[table_imgui[236]], table_binder[table_imgui[236]].v)
                      mainBinder[table_imgui[236]].key = encodeJson(table_binder[table_imgui[236]].v)
                      inicfg.save(mainBinder, "moonloader\\config\\binder.ini")
                    end
                  end

                  imgui.SetCursorPos(imgui.ImVec2(5, 29))
                  imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.30))   
                    imgui.Separator()

                    imgui.SetCursorPosX(60)
                    imgui.Checkbox("###17", table_imgui[237])
    
                    imgui.SameLine()
                    
                    imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"Выключить бинд")

                    imgui.SetCursorPos(imgui.ImVec2(5, 56))  
                    imgui.Separator()
                  imgui.PopStyleColor()

                  imgui.SetCursorPos(imgui.ImVec2(40, 63))
                  if imgui.Button(u8"Сохранить", imgui.ImVec2(170, 23)) and table_imgui[232].v ~= "" then
                    if table_imgui[235].v == "" then
                      table_imgui[235].v = 0 .. ""
                    end
                    for i = 1, 30 do
                      if mainBinder[table_imgui[236]] ~= nil then
                        if mainBinder[table_imgui[236]][i] ~= nil then
                          mainBinder[table_imgui[236]][i] = nil
                        else
                          break
                        end
                      else
                        break
                      end
                    end
                    i = 0
                    for s in string.gmatch(table_imgui[232].v, "[^\r\n]+") do
                      i = i + 1
                      if mainBinder[table_imgui[236]] == nil then
                        mainBinder[table_imgui[236]] = {}
                      end
                      mainBinder[table_imgui[236]][i] = s
                    end
                    mainBinder[table_imgui[236]].wait = table_imgui[235].v
                    mainBinder[table_imgui[236]].name = table_imgui[234].v
                    mainBinder[table_imgui[236]].enabled = table_imgui[237].v
                    inicfg.save(mainBinder, "moonloader\\config\\binder.ini")
                    sampAddChatMessage("{696969} >| {1adb6e}Содержание слота успешно изменено!", -1)
                  end

                imgui.EndChild()

              imgui.EndChild()
            imgui.PopStyleVar()
          imgui.PopStyleColor()
        imgui.PopStyleVar()
      elseif table_imgui[14] then -- департамент
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
            imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
              imgui.BeginChild("###05", imgui.ImVec2(784, 456), true)

              imgui.SetCursorPos(imgui.ImVec2(310, 202))
              imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.75), u8"НАСТРОЙКИ ЮРИСДИКЦИИ")

              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
                imgui.Separator()
              imgui.PopStyleColor()

              imgui.SetCursorPos(imgui.ImVec2(10, 230))
              if imgui.Checkbox("###01", table_imgui[210]) then
                if table_imgui[210].v or not table_imgui[210].v then
                  mainDepart.setting[1] = table_imgui[210].v 
                  inicfg.save(mainDepart, "moonloader\\config\\departamens.ini")
                end
              end

              imgui.SetCursorPos(imgui.ImVec2(39, 224))
              imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 0.90), u8"Показывать окно помощи\nпри нарушении юрисдикции")

              imgui.SetCursorPos(imgui.ImVec2(5, 5))
                imgui.BeginChild("###07", imgui.ImVec2(774, 193), true)

                  imgui.SetCursorPosY(37)
                  imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
                    imgui.Separator()
                  imgui.PopStyleColor()

                  imgui.SetCursorPos(imgui.ImVec2(10, 10))
                  imgui.Text(u8"Ваша организация:")

                  imgui.SameLine()

                  imgui.PushItemWidth(110)
                  imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.00, 0.43, 1.96, 0.95))
                    imgui.InputText("##0005", table_imgui[84])
                  imgui.PopStyleColor()

                  imgui.SameLine()

                  imgui.SetCursorPosY(8)
                  if imgui.Button(u8"Сохранить###0002", imgui.ImVec2(90,22)) then
                    if table_imgui[84].v ~= "" then
                      mainSetting.setting[9] = table_imgui[84].v
                      if inicfg.save(mainSetting, "moonloader\\config\\setting.ini") then
                        sampAddChatMessage("{696969} >| {1adb6e}Департамент успешно сохранен.", -1)
                      end
                    else
                      sampAddChatMessage("{696969} >| {1adb6e}Вы не ввели название департамента.", -1)
                    end
                  end

                  imgui.SetCursorPos(imgui.ImVec2(410, 10))
                  imgui.Text(u8"Канал связи:")

                  imgui.PushItemWidth(140)
                  imgui.SetCursorPos(imgui.ImVec2(490, 9))
                  imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.00, 0.43, 1.96, 0.95))
                    imgui.InputText(u8"##0006", table_imgui[208])
                  imgui.PopStyleColor()

                  imgui.SameLine()

                  imgui.SetCursorPosY(8)
                  if imgui.Button(u8"Сохранить###0001", imgui.ImVec2(90,22)) and table_imgui[208].v ~= "" then
                    mainDepart.dep[table_imgui[209]] = table_imgui[208].v
                    inicfg.save(mainDepart, "moonloader\\config\\departamens.ini")
                  end
              
                  imgui.SetCursorPosY(45)
                  imgui.Columns(3, "006", false)

                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.05, 0.16, 0.38, 1.00))
                      imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.03, 0.22, 1.48, 0.65))
                        for i = 1, 18 do
                          if imgui.Button(mainDepart.dep[i], imgui.ImVec2(242,20)) then
                            table_imgui[209] = i 
                            table_imgui[208].v = mainDepart.dep[table_imgui[209]]
                          end
                          if i == 6 or i == 12 then
                            imgui.NextColumn()
                          end
                        end
                      imgui.PopStyleColor()
                    imgui.PopStyleColor()
                  
                  imgui.Columns(1)
                  
                imgui.EndChild()

              if table_imgui[210].v then

                imgui.PushItemWidth(63)
                imgui.SetCursorPos(imgui.ImVec2(220, 230))
                imgui.Combo(u8"###001", table_imgui[211], {
                  u8"РКШД",
                  u8"ЛВПД",
                  u8"СФПД",
                  u8"ЛСПД",})
                if table_imgui[211].v ~= -1 then
                  mainSetting.setting[12] = table_imgui[211].v
                  inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
                end
            
                imgui.SetCursorPos(imgui.ImVec2(10, 257))
                if imgui.Checkbox("###22", table_imgui[83]) then
                  if table_imgui[83].v or not table_imgui[83].v then
                    mainDepart.setting[2] = table_imgui[83].v 
                    inicfg.save(mainDepart, "moonloader\\config\\departamens.ini")
                  end
                end

                imgui.SetCursorPos(imgui.ImVec2(39, 259))
                imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 0.90), u8"Запрос через рацию (младший состав).")

                imgui.SetCursorPos(imgui.ImVec2(320, 227))
                imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.50), u8"       Даная функция будет контролировать пересечение Вами на любом\nтранспортном средстве каждой из юрисдикций, кроме выбраной из списка,\n             и предлагать сделать об этом доклад в рацию департамента.")

                  imgui.SetCursorPos(imgui.ImVec2(6, 282))
                  imgui.BeginChild("###57", imgui.ImVec2(772, 168), true)

                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.05, 0.16, 0.38, 1.00))
                    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.03, 0.22, 1.48, 0.65))
                    imgui.SetCursorPosY(6)
                    for i = 19, 25 do
                      if imgui.Button(mainDepart[i].name, imgui.ImVec2(130,19)) then
                        table_imgui[82] = i
                        table_imgui[80].v = mainDepart[i].name
                        table_imgui[81].v = mainDepart[i][1]
                      end
                    end
                    imgui.PopStyleColor()
                    imgui.PopStyleColor()

                    imgui.PushItemWidth(140)
                    imgui.SetCursorPos(imgui.ImVec2(150, 6))
                    imgui.InputText("##0017", table_imgui[80])
                    imgui.PushItemWidth(600)
                    imgui.SetCursorPos(imgui.ImVec2(150, 35))
                    imgui.TextColored(imgui.ImVec4(0.00, 0.43, 1.96, 0.95), "/d")
                    imgui.SetCursorPos(imgui.ImVec2(168, 32))
                    imgui.InputText("##0018", table_imgui[81])

                    imgui.SetCursorPos(imgui.ImVec2(150, 56))
                    if imgui.Button(u8"Сохранить###0003", imgui.ImVec2(90,22)) and table_imgui[81].v ~= "" and table_imgui[80].v ~= "" then
                      mainDepart[table_imgui[82]][1] = table_imgui[81].v
                      mainDepart[table_imgui[82]].name = table_imgui[80].v
                      inicfg.save(mainDepart, "moonloader\\config\\departamens.ini")
                    end

                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.20, 0.24, 0.23, 1.00))
                    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.30, 0.34, 0.33, 1.00))
                    imgui.SetCursorPos(imgui.ImVec2(350, 56))
                    if imgui.Button(u8"Теги", imgui.ImVec2(65, 24)) then
                      table_imgui[219] = not table_imgui[219]
                    end
                    imgui.PopStyleColor()
                    imgui.PopStyleColor()

                  imgui.EndChild()
              end

              imgui.EndChild()
            imgui.PopStyleVar()
          imgui.PopStyleColor()
        imgui.PopStyleVar()
      elseif table_imgui[113] then -- рп-оружие
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)

          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))

            imgui.BeginChild("###10", imgui.ImVec2(784, 456), true)

              imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 2)
                if imgui.Checkbox("###02", table_imgui[164]) then
                  if table_imgui[164].v or not table_imgui[164].v then
                    mainbgun.setting[2] = table_imgui[164].v
                    inicfg.save(mainbgun, "moonloader\\config\\guns.ini")
                  end
                end
                imgui.SameLine()
                imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"RP-отыгровки")
                imgui.SameLine()
                if imgui.Checkbox("###03", table_imgui[114]) then
                  if table_imgui[114].v or not table_imgui[114].v then
                    mainbgun.setting[1] = table_imgui[114].v
                    inicfg.save(mainbgun, "moonloader\\config\\guns.ini")
                  end
                end
              imgui.PopStyleVar()

              imgui.SameLine()
              
              imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"RP только при прицеливании у игрока")

              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
                imgui.Separator()
              imgui.PopStyleColor()

              imgui.Columns(3, "002", true)
                for k, v in pairs(test_table) do
                  imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 0.00, 0.00, 1.00))
                  imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.15, 0.15, 0.15, 0.85))
                  imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.25, 0.25, 0.25, 0.90))
                  if imgui.Button(u8(v), imgui.ImVec2(245, 20)) then
                    table_imgui[193].v = ""
                    table_imgui[199].v = ""
                    table_imgui[196] = k
                    table_imgui[197] = test_table[k]
                    if mainbgun[table_imgui[196]] ~= nil then
                      table_imgui[195].v =  "" .. mainbgun[table_imgui[196]].wait
                      table_imgui[194].v = mainbgun[table_imgui[196]].enabled 
                      for i = 1, 9 do
                        if mainbgun[table_imgui[196]][i] then
                          table_imgui[193].v = table_imgui[193].v .. mainbgun[table_imgui[196]][i] .. "\n"
                        end
                      end
                    else
                      table_imgui[193].v = ""
                    end
                    if mainbgun[table_imgui[196] + 50] ~= nil then
                      for i = 1, 9 do
                        if mainbgun[table_imgui[196] + 50][i] then
                          table_imgui[199].v = table_imgui[199].v .. mainbgun[table_imgui[196] + 50][i] .. "\n"
                        end
                      end
                    else
                      table_imgui[199].v = ""
                    end
                  end
                  imgui.PopStyleColor()
                  imgui.PopStyleColor()
                  imgui.PopStyleColor()
                  if k == 14 or k == 31 then
                    imgui.NextColumn()
                  end
                end
              imgui.Columns(1)
              
              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
                imgui.Separator()
              imgui.PopStyleColor()

              if table_imgui[196] ~= "" then
                imgui.SetCursorPos(imgui.ImVec2(6, 378))
                imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 7)
                  imgui.InputTextMultiline(u8"##0005", table_imgui[193], imgui.ImVec2(582, 35), imgui.InputTextFlags.NoHorizontalScroll) -- доставание оружия
                  imgui.SetCursorPos(imgui.ImVec2(5, 417))
                  imgui.InputTextMultiline(u8"##0006", table_imgui[199], imgui.ImVec2(582, 35), imgui.InputTextFlags.NoHorizontalScroll) --убирание оружия
                imgui.PopStyleVar()

                imgui.SameLine()

                imgui.SetCursorPos(imgui.ImVec2(595, 376))
                imgui.BeginChild("###11", imgui.ImVec2(180, 75), true)
                imgui.SetCursorPos(imgui.ImVec2(15, 4))
                imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8(table_imgui[197]))
                  imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 2)
                    imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
                    imgui.Separator()
                    imgui.PopStyleColor()
                    imgui.SetCursorPos(imgui.ImVec2(15, 26))
                    imgui.Checkbox("###04", table_imgui[194])

                    imgui.SameLine()

                    imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"Вкл")

                    imgui.SameLine()

                    imgui.PushItemWidth(30)
                    imgui.SetCursorPos(imgui.ImVec2(78, 26))
                    imgui.InputText("##0007", table_imgui[195])

                    imgui.SameLine()

                    imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"Задержка")
                    imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
                    imgui.Separator()
                    imgui.PopStyleColor()

                    imgui.SameLine()
                
                    imgui.SetCursorPos(imgui.ImVec2(30, 52))
                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.10, 0.30, 0.55, 0.65))
                    if imgui.Button(u8"Сохранить", imgui.ImVec2(120, 19)) and table_imgui[193].v ~= "" and table_imgui[195].v ~= "" and table_imgui[199].v ~= "" then
                      for i = 1, 30 do
                        if mainbgun[table_imgui[196]] ~= nil then
                          if mainbgun[table_imgui[196]][i] ~= nil then
                            mainbgun[table_imgui[196]][i] = nil
                          else
                            break
                          end
                        else
                          break
                        end
                      end
                      i = 0
                      for s in string.gmatch(table_imgui[193].v, "[^\r\n]+") do
                        i = i + 1
                        if mainbgun[table_imgui[196]] == nil then
                          mainbgun[table_imgui[196]] = {}
                        end
                        mainbgun[table_imgui[196]][i] = s
                      end
                      mainbgun[table_imgui[196]].wait = table_imgui[195].v
                      mainbgun[table_imgui[196]].enabled = table_imgui[194].v
                      inicfg.save(mainbgun, "moonloader\\config\\guns.ini")
                      sampAddChatMessage("{696969} >| {1adb6e}RP-отыгровки для [{ff692e}" .. test_table[table_imgui[196]] .. "{1adb6e}] успешно изменены!", -1)
                      for i = 1, 30 do
                        if mainbgun[table_imgui[196] + 50] ~= nil then
                          if mainbgun[table_imgui[196] + 50][i] ~= nil then
                            mainbgun[table_imgui[196] + 50][i] = nil
                          else
                            break
                          end
                        else
                          break
                        end
                      end
                      i = 0
                      for s in string.gmatch(table_imgui[199].v, "[^\r\n]+") do
                        i = i + 1
                        if mainbgun[table_imgui[196] + 50] == nil then
                          mainbgun[table_imgui[196] + 50] = {}
                        end
                        mainbgun[table_imgui[196] + 50][i] = s
                      end
                      inicfg.save(mainbgun, "moonloader\\config\\guns.ini")
                    end
                    imgui.PopStyleColor()
                  imgui.PopStyleVar()
              imgui.EndChild()
            end
            imgui.EndChild()
          imgui.PopStyleColor()
        imgui.PopStyleVar()
      elseif table_imgui[179] then -- пиеменю
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
            imgui.BeginChild("###12", imgui.ImVec2(784, 456), true)
              imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
                if imgui.Checkbox("###05", table_imgui[190]) then
                  if table_imgui[190].v or not table_imgui[190].v then
                    mainSetting.setting[10] = table_imgui[190].v
                    inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
                    sampAddChatMessage("{696969} >| {1adb6e}Режим отображения кругового меню изменен.", -1)
                  end
                end
                imgui.SameLine()
                imgui.TextColored(imgui.ImVec4(0.90, 0.90, 0.90, 0.70), u8"Круговое меню")
                imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
                  imgui.Separator()
                imgui.PopStyleColor()
                if table_imgui[190].v then
                  imgui.BeginChild("###13", imgui.ImVec2(150, 413), true)
                    for i = 1, 60 do
                      imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.05, 0.16, 0.38, 1.00))
                      if imgui.Button("" .. u8:decode(mainBind[i].name), imgui.ImVec2(120, 20))  then
                        table_imgui[180].v = ""
                        table_imgui[189] = i
                        table_imgui[187].v = u8:decode(mainBind[i].name .. "")
                        if table_imgui[189] <= 10 and table_imgui[189] ~= 0 then
                          table_imgui[192] = "X"
                        elseif  table_imgui[189] <= 20 and table_imgui[189] ~= 10 then
                          table_imgui[192] = "Y"
                        elseif  table_imgui[189] <= 30 and table_imgui[189] ~= 20 then
                          table_imgui[192] = "Z"
                        elseif  table_imgui[189] <= 40 and table_imgui[189] ~= 30 then
                          table_imgui[192] = "P"
                        elseif  table_imgui[189] <= 50 and table_imgui[189] ~= 40 then
                          table_imgui[192] = "O"
                        elseif  table_imgui[189] <= 60 and table_imgui[189] ~= 50 then
                          table_imgui[192] = "H"
                        end
                        if mainBind[table_imgui[189]] ~= nil then
                          table_imgui[188].v =  "" .. mainBind[table_imgui[189]].wait
                          for j = 1, 35 do
                            if mainBind[table_imgui[189]][j] then
                              table_imgui[180].v = table_imgui[180].v .. mainBind[table_imgui[189]][j] .. "\n"
                            end
                          end
                        else
                          table_imgui[180].v = ""
                        end
                      end
                      imgui.PopStyleColor()
                    end
                  imgui.EndChild()
                  imgui.SetCursorPos(imgui.ImVec2(625, 41))
                  imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.75), u8"Слот основного круга: " .. table_imgui[192])
                  if type(table_imgui[189]) == "number" then
                    imgui.PushItemWidth(100)
                    imgui.SetCursorPos(imgui.ImVec2(166, 40))
                    imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
                      imgui.InputText("##0008", table_imgui[187])
                      imgui.SameLine()
                      imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.75), u8"Название")
                      imgui.SameLine()
                      imgui.PushItemWidth(40)
                      imgui.SetCursorPos(imgui.ImVec2(405, 40))
                      imgui.InputText("##0009", table_imgui[188])
                      imgui.SameLine()
                      imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.75), u8"Задержка (сек)")
                    imgui.PopStyleVar()
                    imgui.PushItemWidth(140)
                    imgui.SetCursorPos(imgui.ImVec2(165, 65))
                    imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 7)
                      imgui.InputTextMultiline(u8"##0010", table_imgui[180], imgui.ImVec2(610, 150))
                    imgui.PopStyleVar()
                    imgui.SetCursorPos(imgui.ImVec2(167, 220))
                    if imgui.Button(u8"Сохранить", imgui.ImVec2(75, 24)) and table_imgui[180].v ~= "" then
                      if table_imgui[188].v == "" then
                        table_imgui[188].v = 0 .. ""
                      end
                      if table_imgui[187].v == "" then
                        sampAddChatMessage("{696969} >| {1adb6e}Заполните все поля!", -1)
                      else
                        for i = 1, 30 do
                          if mainBind[table_imgui[189]] ~= nil then
                            if mainBind[table_imgui[189]][i] ~= nil then
                              mainBind[table_imgui[189]][i] = nil
                            else
                              break
                            end
                          else
                            break
                          end
                        end
                        i = 0
                        for s in string.gmatch(table_imgui[180].v, "[^\r\n]+") do
                          i = i + 1
                          if mainBind[table_imgui[189]] == nil then
                            mainBind[table_imgui[189]] = {}
                          end
                          mainBind[table_imgui[189]][i] = s
                        end
                        mainBind[table_imgui[189]].wait = table_imgui[188].v
                        mainBind[table_imgui[189]].name = u8(table_imgui[187].v .. "")
                        inicfg.save(mainBind, "moonloader\\config\\binder_as.ini")
                        sampAddChatMessage("{696969} >| {1adb6e}Содержание слота успешно изменено!", -1)
                      end
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosX(330)
                    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.20, 0.24, 0.23, 1.00))
                      imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.30, 0.34, 0.33, 1.00))
                        if imgui.Button(u8"Теги", imgui.ImVec2(65, 24)) then
                          table_imgui[219] = not table_imgui[219]
                        end
                      imgui.PopStyleColor()
                    imgui.PopStyleColor()
                    imgui.SetCursorPos(imgui.ImVec2(305, 431))
                    imgui.TextColored(imgui.ImVec4(2.55, 0.10, 0.10, 0.65), u8"Чем длинее название слота - тем больше размер секции.")
                  end
                end
              imgui.PopStyleVar()
            imgui.EndChild()
          imgui.PopStyleColor()
        imgui.PopStyleVar()
      elseif table_imgui[13] then -- диспетчерская
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
        imgui.BeginChild("###14", imgui.ImVec2(784, 456), true)

        imgui.SetCursorPos(imgui.ImVec2(340, 210))
        imgui.Text(u8"В разработке...")

        imgui.EndChild()
        imgui.PopStyleColor()
        imgui.PopStyleVar()
      elseif table_imgui[220] then -- собеседования
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
        imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
        imgui.BeginChild("###15", imgui.ImVec2(784, 456), true)

          imgui.BeginChild("###16", imgui.ImVec2(500, 440), true)
          imgui.PushItemWidth(150)
          imgui.InputText("###010", table_imgui[225])
          imgui.SameLine()
          imgui.TextColored(imgui.ImVec4(0.90, 0.90, 0.90, 0.70), u8"Название")
          imgui.SameLine()
          imgui.PushItemWidth(50)
          imgui.SetCursorPosX(280)
          imgui.InputText("###011", table_imgui[226])
          imgui.SameLine()
          imgui.TextColored(imgui.ImVec4(0.90, 0.90, 0.90, 0.70), u8"Задержка (сек)")
          imgui.InputTextMultiline("##0004", table_imgui[224], imgui.ImVec2(484, 90))
          if imgui.Button(u8"Сохранить", imgui.ImVec2(90, 23)) and table_imgui[224].v ~= "" then
            if table_imgui[226].v == "" then
              table_imgui[226].v = 0 .. ""
            end
            if table_imgui[226].v == "" or table_imgui[225].v == "" then
              sampAddChatMessage("{696969} >| {1adb6e}Заполните все поля!", -1)
            else
              for i = 1, 30 do
                if mainInterviews[table_imgui[227]] ~= nil then
                  if mainInterviews[table_imgui[227]][i] ~= nil then
                    mainInterviews[table_imgui[227]][i] = nil
                  else
                    break
                  end
                else
                  break
                end
              end
              i = 0
              for s in string.gmatch(table_imgui[224].v, "[^\r\n]+") do
                i = i + 1
                if mainInterviews[table_imgui[227]] == nil then
                  mainInterviews[table_imgui[227]] = {}
                end
                mainInterviews[table_imgui[227]][i] = s
              end
              mainInterviews[table_imgui[227]].wait = table_imgui[226].v
              mainInterviews[table_imgui[227]].name = table_imgui[225].v
              inicfg.save(mainInterviews, "moonloader\\config\\interviews.ini")
              sampAddChatMessage("{696969} >| {1adb6e}Содержание слота успешно изменено!", -1)
            end
          end

          imgui.SameLine()
          imgui.SetCursorPosX(195)
          imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.20, 0.24, 0.23, 1.00))
          imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.30, 0.34, 0.33, 1.00))
          if imgui.Button(u8"Теги", imgui.ImVec2(65, 24)) then
            table_imgui[219] = not table_imgui[219]
          end
          imgui.SameLine()
          imgui.SetCursorPos(imgui.ImVec2(320, 128))
          imgui.Checkbox("###15", table_imgui[228])
          imgui.SameLine()
          imgui.TextColored(imgui.ImVec4(0.90, 0.90, 0.90, 0.70), u8"Режим редактирования")
          imgui.PopStyleColor()
          imgui.PopStyleColor()

          imgui.EndChild()

          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.45))
          imgui.SetCursorPos(imgui.ImVec2(513, 8))
          imgui.BeginChild("###36", imgui.ImVec2(263, 440), true)

          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(2.19, 2.19, 2.19, 0.50))
          imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(2.19, 2.19, 2.19, 0.50)) 
          imgui.SetCursorPos(imgui.ImVec2(67, 7))
          imgui.BeginChild("###18", imgui.ImVec2(135, 31), true)

          imgui.SetCursorPos(imgui.ImVec2(11, 9))
          imgui.Text(u8"СПИСОК ВОПРОСОВ")

          imgui.EndChild()
          imgui.PopStyleColor()
          imgui.PopStyleColor()

          imgui.SetCursorPos(imgui.ImVec2(5, 22))
          imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(2.19, 2.19, 2.19, 0.50))   
            imgui.Separator()
            imgui.SetCursorPos(imgui.ImVec2(5, 23))
            imgui.Separator()
          imgui.PopStyleColor()

          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
            imgui.SetCursorPos(imgui.ImVec2(7, 48))
            imgui.BeginChild("###19", imgui.ImVec2(248, 316), true)

              imgui.SetCursorPos(imgui.ImVec2(9, 5))

              for i = 1, 10 do
                imgui.PushStyleColor(imgui.Col.CheckMark, imgui.ImVec4(0.49, 2.45, 0.10, 0.80))
                imgui.Checkbox("###00" .. i, checkbox_bool[i])
                imgui.PopStyleColor()
                imgui.SameLine()
                imgui.PushStyleColor(imgui.Col.CheckMark, imgui.ImVec4(2.30, 0.20, 0.16, 0.80))
                imgui.Checkbox("###000" .. i, checkbox_bool[i + 10])

                imgui.PopStyleColor()
                imgui.SameLine()
                if imgui.Button(u8"" .. mainInterviews[i].name, imgui.ImVec2(175, 21)) then
                  table_imgui[224].v = ""
                  if table_imgui[228].v then
                    table_imgui[227] = i
                    table_imgui[225].v = mainInterviews[i].name .. ""
                    if table_imgui[227] ~= nil then
                      table_imgui[226].v = mainInterviews[table_imgui[227]].wait .. ""
                      for j = 1, 10 do
                        if mainInterviews[table_imgui[227]][j] then
                          table_imgui[224].v = table_imgui[224].v .. mainInterviews[table_imgui[227]][j] .. "\n"
                        end
                      end
                    else
                      table_imgui[224].v = ""
                    end
                  elseif not table_imgui[228].v then
                    thread_cmen:run("interview" .. i)
                  end
                end
              end

              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(2.19, 2.19, 2.19, 0.40))   
                imgui.Separator()

                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.21, 1.79, 0.61, 0.40))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.31, 1.90, 0.61, 0.50))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.15, 1.80, 0.50, 0.20)) 
                if imgui.Button(u8"Одобрение", imgui.ImVec2(111, 21)) then
                  sampSendChat("Поздравляю, Вы приняты в нашу Академию. Уверен, не пожалеете!")
                  table_imgui[222] = "-"
                  table_imgui[223] = "-"
                  for i = 1, 20 do
                    checkbox_bool[i] = imgui.ImBool(false)
                  end
                end
                imgui.PopStyleColor()
                imgui.PopStyleColor()
                imgui.PopStyleColor()

                imgui.SameLine()

                imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(2.30, 0.16, 0.16, 0.40))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(2.30, 0.26, 0.26, 0.50))
                imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(2.20, 0.10, 0.10, 0.20)) 
                if imgui.Button(u8"Отказ", imgui.ImVec2(111, 21)) then
                  sampSendChat("Вам отказано. Всего хорошего!")
                  table_imgui[222] = "-"
                  table_imgui[223] = "-"
                  for i = 1, 20 do
                    checkbox_bool[i] = imgui.ImBool(false)
                  end
                end
                imgui.PopStyleColor()
                imgui.PopStyleColor()
                imgui.PopStyleColor()
  
                imgui.Separator()
              imgui.PopStyleColor()

              imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.56, 0.56, 0.56, 0.70))
              imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.62, 0.65, 0.60, 0.80))
              imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.56, 0.56, 0.56, 0.30)) 
              if imgui.Button(u8"Тайм", imgui.ImVec2(72, 21)) then
                lua_thread.create(function() 
                  sampSendChat("/id ".. table_imgui[19]) 
                  wait(600) 
                  sampSendChat("/time") 
                end)
              end
              imgui.SameLine()
              if imgui.Button(u8"Скрин", imgui.ImVec2(72, 21)) then
                lua_thread.create(function()
                  sampSendChat("/time") 
                  wait(300)
                  setVirtualKeyDown(vkey.VK_F8, true)
                  wait(100)
                  setVirtualKeyDown(vkey.VK_F8, false)
                end)
              end
              imgui.SameLine()
              if imgui.Button(u8"Помощь", imgui.ImVec2(72, 21)) then
                if table_imgui[101] == "1" then
                  sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to [All]: Нужны сотрудники из старшего состава для помощи на собеседовании.")
                  table_imgui[101] = "2"
                elseif table_imgui[101] == "2" then
                  sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to [All]: Нужны сотрудники из старшего состава для помощи на собеседовании. *повторяя*")
                  table_imgui[101] = "1"
                end
              end
              imgui.PopStyleColor()
              imgui.PopStyleColor()
              imgui.PopStyleColor()
              
            imgui.EndChild()

            imgui.SetCursorPos(imgui.ImVec2(7, 370))
            imgui.BeginChild("###20", imgui.ImVec2(248, 64), true)

              imgui.SetCursorPos(imgui.ImVec2(65, 3))
              imgui.TextColored(imgui.ImVec4(0.90, 0.90, 0.90, 0.70), u8"Краткая информация")

              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(2.19, 2.19, 2.19, 0.35))   
              imgui.Separator()
              imgui.PopStyleColor()

              imgui.TextColored(imgui.ImVec4(0.58, 1.84, 0.33, 0.95), u8"Кандидат:")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(72, 25))
              imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.70), u8"________________________")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(72, 24))
              imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 0.90), table_imgui[222] .. "")
              imgui.SetCursorPosX(15)
              imgui.TextColored(imgui.ImVec4(0.58, 1.84, 0.33, 0.95), u8"Уровень:")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(72, 43))
              imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.70), u8"________________________")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(72, 42))
              imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 0.90), table_imgui[223] .. "")

            imgui.EndChild()
            imgui.PopStyleColor()

          imgui.EndChild()
          imgui.PopStyleColor()

        imgui.EndChild()
        imgui.PopStyleVar()
        imgui.PopStyleColor()
        imgui.PopStyleVar()
      end

      if not table_imgui[219] then -- меню тегов
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
            imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
              imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.15, 0.35, 0.75, 0.35))
                imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.05, 0.05, 0.05, 1.00))

                  imgui.SetCursorPos(imgui.ImVec2(8, 601))
                  imgui.BeginChild("###21", imgui.ImVec2(784, 190), true)

                    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.00, 1.43, 0.24, 0.35))
                      imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(0.00, 1.43, 0.24, 0.35)) 

                      imgui.SetCursorPos(imgui.ImVec2(330, 7))
                      imgui.BeginChild("###22", imgui.ImVec2(145, 31), true)

                        imgui.SetCursorPos(imgui.ImVec2(28, 9))
                        imgui.Text(u8"СПИСОК ТЕГОВ")

                      imgui.EndChild()
                      
                      imgui.PopStyleColor()
                    imgui.PopStyleColor()

                    imgui.SetCursorPos(imgui.ImVec2(5, 22))
                    imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.00, 1.43, 0.24, 0.35))   
                      imgui.Separator()
                      imgui.SetCursorPos(imgui.ImVec2(5, 23))
                      imgui.Separator()
                    imgui.PopStyleColor() 

                    imgui.SetCursorPosY(45)
                    imgui.Columns(2, "013", false)
                
                    imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
                    imgui.Separator()
                    imgui.PopStyleColor()

                    for i, v in ipairs(tegs_desc) do 
                      if imgui.Button(v[1], imgui.ImVec2(181, 22)) then
                        setClipboardText(v[1])
                      end
                      imgui.SameLine()
                      imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.85), u8(v[2]))
                      if i == 8 then
                        imgui.NextColumn()
                      end
                    end

                  imgui.EndChild()

                imgui.PopStyleColor()
              imgui.PopStyleColor()
            imgui.PopStyleVar()
          imgui.PopStyleColor()
        imgui.PopStyleVar()
      end

    imgui.End()

  end

	if table_imgui[21].v then -- меню 10-55
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(-3.7, 0.72))
		imgui.SetNextWindowSize(imgui.ImVec2(200, 309), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"           МЕНЮ 10-55", table_imgui[21], imgui.WindowFlags.NoResize)

    imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
      imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
        imgui.SetCursorPosY(24)
          imgui.BeginChild("###23", imgui.ImVec2(185, 45), true)

            imgui.SetCursorPos(imgui.ImVec2(20, 15))
            imgui.TextColored(imgui.ImVec4(0.00, 1.02, 0.14, 1.0), u8"Айди:")

            imgui.SameLine()

            imgui.Text(arg_su)

            imgui.SetCursorPos(imgui.ImVec2(100, 15))
            imgui.TextColored(imgui.ImVec4(0.00, 1.02, 0.14, 1.0), u8"Уровень:")

            imgui.SameLine()
            
            imgui.SetCursorPosX(155)
            imgui.Text("" .. sampGetPlayerScore(arg_su))

          imgui.EndChild()

          imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.30))   
          imgui.Separator()

          imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 2)
          imgui.BeginChild("###24", imgui.ImVec2(185, 84), true)

            if imgui.Button(u8"Фара", imgui.ImVec2(80,20)) then
              sampSendChat("/me оставляет отпечаток на задней фаре транспортого средства.")
            end

            imgui.SameLine()

            if imgui.Button(u8"Окно", imgui.ImVec2(80,20)) then
              sampSendChat("/do Окно опущено?")
            end

            if imgui.Button(u8"Документы", imgui.ImVec2(80,20)) then
              threads_command:run(14)
            end

            imgui.SameLine()

            if imgui.Button(u8"Штраф", imgui.ImVec2(80,20)) then
              table_imgui[24].v = true
              table_imgui[38].v = -1
              table_imgui[182].v = -1
            end

            imgui.SetCursorPos(imgui.ImVec2(47, 57))
            if imgui.Button(u8"Прощание", imgui.ImVec2(90,20)) then
              sampSendChat("Всего хорошего, не нарушайте!")
            end

          imgui.EndChild()

          imgui.Separator()
          
          imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(2.56, 0.26, 0.00, 0.65))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(2.01, 0.20, 0.00, 0.95))
            imgui.BeginChild("###25", imgui.ImVec2(185, 60), true)

              if imgui.Button(u8"10-57V", imgui.ImVec2(80,20)) then
                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [All]: IO-57VICTOR, номер " .. arg_su .. ", движемся в сторону " .. rajon() .. ", нужна помощь, nRFR, over.")
                table_imgui[21].v = false
              end

              imgui.SameLine()

              if imgui.Button(u8"10-66", imgui.ImVec2(80,20)) then
                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [All]: провожу IO-66, нахожусь в " .. rajon() .. ", номер " .. arg_su .. ", нужна помощь, nRFR, over.")
              end

              if imgui.Button(u8"Cod-3", imgui.ImVec2(80,20)) then
                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [All]: нужна помощь ближайших патрулей, нахожусь в " .. rajon() .. ", к-т " .. kvadrat() .. ", nRFR, over.")
              end

              imgui.SameLine()
              
              if imgui.Button(u8"Cod-0", imgui.ImVec2(80,20)) then
                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [All]: под огнем, срочно нужна помощь, нахожусь в " .. rajon() .. ", к-т " .. kvadrat() .. ", nRFR, over.")
              end

            imgui.EndChild()

            imgui.Separator()
            imgui.PopStyleColor() 

            imgui.BeginChild("###26", imgui.ImVec2(185, 65), true)
            
              if imgui.Button(u8"В розыск", imgui.ImVec2(80,22)) then
                table_imgui[24].v = true
              end

              imgui.SameLine()

              if imgui.Button(u8"Вытащить", imgui.ImVec2(80,22)) then
                sampSendChat("/pull " .. arg_su)
                threads_command:run(3)
              end

              imgui.SetCursorPos(imgui.ImVec2(48, 35))
              imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.35, 0.35, 0.35, 0.65))
              if imgui.Button(u8"Завершить", imgui.ImVec2(90,22)) then
                if table_imgui[244].v then
                  sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: закончил проводить трафик-стоп 55, продолжаю патрулирование, RFR, over.")
                end
                table_imgui[21].v = false
              end
              imgui.PopStyleColor()

            imgui.EndChild()
            
            imgui.PopStyleColor()
          imgui.PopStyleColor()
        imgui.PopStyleVar()
      imgui.PopStyleColor()
    imgui.PopStyleVar()

		imgui.End()
	end
  
	if table_imgui[24].v then -- УК АК
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(775, 1056), imgui.Cond.FirstUseEver)
		imgui.Begin("###01", table_imgui[24], imgui.WindowFlags.NoResize)

    imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
      imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))

        imgui.SetCursorPos(imgui.ImVec2(7, 572))
        imgui.BeginChild("###27", imgui.ImVec2(760, 30), true) -- первый чилд

          imgui.SetCursorPos(imgui.ImVec2(10, 7))
          imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.75), u8"Айди преступника:")
          imgui.SameLine()
          imgui.Text(arg_su)

          imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
          imgui.SameLine()

          imgui.SetCursorPos(imgui.ImVec2(170, 5))
          if imgui.Checkbox("###06", table_imgui[230]) then
            if table_imgui[230].v or not table_imgui[230].v then
              mainSetting.setting[7] = table_imgui[230].v
              inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
            end
          end
          imgui.SameLine()
          imgui.SetCursorPosY(4)
          imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.75), u8"Запрашивать розыск через рацию")

          imgui.SameLine()

          imgui.SetCursorPos(imgui.ImVec2(425, 5))
          if imgui.Checkbox("###07", table_imgui[231]) then
            if table_imgui[231].v or not table_imgui[231].v then
              mainSetting.setting[8] = table_imgui[231].v
              inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
            end
          end
          imgui.SameLine()
          imgui.SetCursorPosY(4)
          imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.75), u8"Выдавать розыск по запросу")

          imgui.SameLine()
          imgui.SetCursorPos(imgui.ImVec2(638, 5))
          if imgui.Checkbox("###08", table_imgui[212]) then
            if table_imgui[212].v or not table_imgui[212].v then
              mainSetting.setting[13] = table_imgui[212].v
              inicfg.save(mainSetting, "moonloader\\config\\setting.ini")
            end
          end
          imgui.PopStyleVar()
          imgui.SameLine()
          imgui.SetCursorPosY(4)
          imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.75), u8"Включить RP")

        imgui.EndChild()

        imgui.SetCursorPosY(615)
        imgui.PushStyleColor(imgui.Col.ScrollbarGrab, imgui.ImVec4(0.01, 0.00, 0.71, 0.00))
        imgui.PushStyleColor(imgui.Col.ScrollbarGrabHovered, imgui.ImVec4(0.01, 0.00, 0.71, 0.00))
        imgui.PushStyleColor(imgui.Col.ScrollbarGrabActive, imgui.ImVec4(0.01, 0.00, 0.71, 0.00))
        imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, -0.10, 0.00, 0.10))  
        imgui.InputTextMultiline(u8"##000533", table_imgui[89], imgui.ImVec2(758, 417))
        imgui.PopStyleColor() 
        imgui.PopStyleColor() 
        imgui.PopStyleColor()
        imgui.PopStyleColor() 
        imgui.SetCursorPos(imgui.ImVec2(7, 209))
        imgui.BeginChild("###67", imgui.ImVec2(760, 52), true)

            imgui.SetCursorPos(imgui.ImVec2(5, 25))
            imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.01, 0.00, 0.71, 0.75))   
              imgui.Separator()
              imgui.SetCursorPos(imgui.ImVec2(5, 26)) 
              imgui.Separator()
            imgui.PopStyleColor() 

              imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.01, 0.00, 0.71, 0.75))
              imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(0.01, 0.00, 0.71, 0.75)) 
              imgui.SetCursorPos(imgui.ImVec2(310, 10))
              imgui.BeginChild("###29", imgui.ImVec2(145, 31), true)

                imgui.SetCursorPosY(8)
                imgui.SetCursorPosX(12)
                imgui.Text(u8"УГОЛОВНЫЙ КОДЕКС")

              imgui.EndChild()
              imgui.PopStyleColor()
              imgui.PopStyleColor()

        imgui.EndChild()

        imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 10)
        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.05, 0.05, 0.05, 0.55))
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.01, 0.20, 1.43, 0.55))
        imgui.SetCursorPos(imgui.ImVec2(7, 261))
        imgui.BeginChild("###28", imgui.ImVec2(760, 311), true) -- второй чилд (УК)

          imgui.PushItemWidth(730)
          for i = 2, #ug_codex, 2 do
            imgui.SetCursorPosY(i * 12 - 10)
            imgui.SetCursorPosX(9)
            if imgui.Combo("###0000" .. i, table_imgui[182], ug_codex[i], #ug_codex) then
              for n = 0, #ug_codex[i] do
                if table_imgui[182].v == n then
                  local numberst = string.match(ug_codex[i][n+1], "%d*%.%d*%.[%d*]?")
                  local numberlvl = string.match(ug_codex[i][n+1], "%[(%d*)%]")
                  table_imgui[24].v = table_imgui[162]
                  if isKeyDown(vkey.VK_MENU) then
                    local textst = string.match(ug_codex[i][n+1], "%d*%.%d*%.[%d*]? (.+)%.%s.+")
                    sampSendChat("Нарушена статья " .. numberst .. " УК, " .. u8:decode(textst) .. ".")
                  elseif not table_imgui[230].v then
                    -- sampAddChatMessage("fwef " .. n .. " " .. i .. " " .. numberst .. " " .. numberlvl, -1)
                    sampSendChat("/su " .. arg_su .. " " .. numberlvl .. " " .. numberst .. " ЕФК")
                  elseif table_imgui[230].v then
                    thread_su_zapros:run(arg_su, numberlvl, numberst)
                  end
                end
              end
            end
          end
          for k = 1, #ug_codex, 2 do
            imgui.SetCursorPosY(k * 12 + 5)
            imgui.SetCursorPosX(25)
            imgui.Text(table.concat(ug_codex[k]))
          end

        imgui.EndChild()

          imgui.SetCursorPos(imgui.ImVec2(5, 202))
          imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.20, 0.20, 0.20, 1.00))   
            imgui.Separator()
            imgui.SetCursorPos(imgui.ImVec2(5, 201))
            imgui.Separator()
          imgui.PopStyleColor() 

          imgui.SetCursorPos(imgui.ImVec2(7, 25))
          imgui.BeginChild("###66", imgui.ImVec2(760, 53), true)

            imgui.SetCursorPos(imgui.ImVec2(5, 27))
              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.01, 0.00, 0.71, 0.75))   
              imgui.Separator()
              imgui.SetCursorPos(imgui.ImVec2(5, 26))
              imgui.Separator()
            imgui.PopStyleColor() 

            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.01, 0.00, 0.71, 0.75))
            imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(0.01, 0.00, 0.71, 0.75)) 
            imgui.SetCursorPos(imgui.ImVec2(280, 11))
            imgui.BeginChild("###31", imgui.ImVec2(205, 31), true)

              imgui.SetCursorPos(imgui.ImVec2(12, 8))
              imgui.Text(u8"АДМИНИСТРАТИВНЫЙ КОДЕКС")

            imgui.EndChild()
            imgui.PopStyleColor()
            imgui.PopStyleColor()

          imgui.EndChild()

          imgui.SetCursorPos(imgui.ImVec2(7, 78))
          imgui.BeginChild("###30", imgui.ImVec2(760, 117), true) -- третий чилд (АК)

          imgui.PushItemWidth(730)
          for i = 2, #ak_codex, 2 do
            imgui.SetCursorPosY(i * 12 - 10)
            imgui.SetCursorPosX(9)
            if imgui.Combo("###0003" .. i, table_imgui[38], ak_codex[i], #ak_codex) then
              for n = 0, #ak_codex[i] do
                if table_imgui[38].v == n then
                  local numberst = string.match(ak_codex[i][n+1], "%d*%.%d*%.[%d*]?")
                  local numbermoney = string.match(ak_codex[i][n+1], "(%d*)%$")
                  table_imgui[24].v = table_imgui[162]
                  if isKeyDown(vkey.VK_MENU) then
                    local textst = string.match(ak_codex[i][n+1], "%d*%.%d*%.[%d*]? (.+)%.")
                    sampSendChat("Нарушена статья " .. numberst .. " АК, " .. u8:decode(textst) .. ".")
                  else
                    sampSendChat("/ticket " .. arg_su .. " " .. numbermoney .. " " .. numberst .. " АК")
                    sampAddChatMessage("fwef " .. n .. " " .. i .. " " .. numberst .. " " .. numbermoney, -1)
                  end
                end
              end
            end
          end
          for k = 1, #ak_codex, 2 do
            imgui.SetCursorPosY(k * 12 + 5)
            imgui.SetCursorPosX(25)
            imgui.Text(table.concat(ak_codex[k]))
          end

          imgui.EndChild()
          imgui.PopStyleColor()
          imgui.PopStyleColor()

        imgui.PopStyleVar()
      imgui.PopStyleColor()
    imgui.PopStyleVar()
		
		imgui.End()
	end
	
	if table_imgui[26].v then -- запрос розыска
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(-3.50, 1.20))
		imgui.SetNextWindowSize(imgui.ImVec2(161, 186), imgui.Cond.FirstUseEver)
		imgui.Begin("###02", table_imgui[26], imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
      imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
          imgui.BeginChild("###32", imgui.ImVec2(145, 170), true)

            imgui.SetCursorPos(imgui.ImVec2(20, 7))
            imgui.TextColored(imgui.ImVec4(0.24, 0.57, 2.19, 1.0), u8"ЗАПРОС РОЗЫСКА:")

            imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.30))   
              imgui.Separator()

              imgui.Columns(2, "003", true)
                imgui.SetCursorPosX(19)
                imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.90), u8"Айди:")
                imgui.SetCursorPosX(10)
                imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.90), u8"Причина:")
                imgui.SetCursorPosX(12)
                imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.90), u8"Степень:")
                imgui.NextColumn()
                imgui.TextColored(imgui.ImVec4(0.05, 2.50, 0.38, 0.95), "" .. table_imgui[115])
                imgui.TextColored(imgui.ImVec4(0.05, 2.50, 0.38, 0.95), "" .. table_imgui[117])
                imgui.TextColored(imgui.ImVec4(0.05, 2.50, 0.38, 0.95), "" .. table_imgui[116])
              imgui.Columns(1)

              imgui.Separator()
            imgui.PopStyleColor() 

            imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 2)
              imgui.SetCursorPos(imgui.ImVec2(8, 91))
              if imgui.Button(u8"Выдать", imgui.ImVec2(60, 23)) then
                threads_su_umn:run()
              end
              imgui.SameLine()
              if imgui.Button(u8"Закрыть", imgui.ImVec2(60, 23)) then
                table_imgui[26].v = not table_imgui[26].v
                table_imgui[5] = "0"
                table_imgui[115] = ""
                table_imgui[116] = ""
                table_imgui[117] = ""
              end

              imgui.SetCursorPos(imgui.ImVec2(10, 121))
              imgui.Checkbox("###12", table_imgui[213])
              imgui.SameLine()
              imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.90), u8"Тайм")
              imgui.SetCursorPosX(10)
              imgui.Checkbox("###13", table_imgui[214])
              imgui.SameLine()
              imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.90), u8"Скриншот")
            imgui.PopStyleVar()

          imgui.EndChild()
        imgui.PopStyleColor()
      imgui.PopStyleVar()
    imgui.End()
	end

	if table_imgui[27].v then -- рация департамента
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(231, 345), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"      РАЦИЯ ДЕПАРТАМЕНТА", table_imgui[27], imgui.WindowFlags.NoResize)

      imgui.SetCursorPos(imgui.ImVec2(56, 25))
      imgui.TextColored(imgui.ImVec4(0.26, 0.29, 2.55, 1.0), u8"/d [" .. mainSetting.setting[9] .. "] - [" .. table_imgui[33] .. "]:")

      imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.45))
      imgui.Separator()

      imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
      imgui.Columns(2, "007", false)
      for i = 1, 18 do
        if imgui.Button("[" .. mainDepart.dep[i] .. "]", imgui.ImVec2(100, 25)) then
          table_imgui[33] = mainDepart.dep[i]
        end
        if i == 9 then
          imgui.NextColumn()
        end
      end
      imgui.Columns(1)

      imgui.Separator()
      imgui.PopStyleColor()

      imgui.SetCursorPos(imgui.ImVec2(15, 314))
      imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.26, 0.26, 0.20, 0.90))
      imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.30, 0.32, 0.25, 0.85))
      if imgui.Button(u8"Отмена", imgui.ImVec2(200, 25)) then
        table_imgui[33] = ""
      end
      imgui.PopStyleColor()
      imgui.PopStyleColor()
      imgui.PopStyleVar()

		imgui.End()
	end

	if table_imgui[174].v then -- окно в патруле
    -- local x, y, z = getCharCoordinates(PLAYER_PED)
		table_imgui[173].v = table_imgui[173].v + 1 

    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.3, -2.85))
		imgui.SetNextWindowSize(imgui.ImVec2(450, 150), imgui.Cond.FirstUseEver)
		imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.05))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.43, 0.37, 0.37, 0.35))
		imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.38, 0.38, 0.38, 0.90))
		imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(0.38, 0.38, 0.38, 0.90))
		imgui.Begin("###patrol", imgui.ImInt(0), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)

    imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 7)

      imgui.SameLine()

      imgui.SetCursorPos(imgui.ImVec2(25, 23))
      imgui.BeginChild("###48", imgui.ImVec2(7, 15), true) -- ножка
      imgui.EndChild()

      imgui.SameLine()

      imgui.SetCursorPos(imgui.ImVec2(84, 23))
      imgui.BeginChild("###49", imgui.ImVec2(7, 15), true) -- ножка
      imgui.EndChild()

      imgui.SameLine()

      imgui.SetCursorPos(imgui.ImVec2(170, 23))
      imgui.BeginChild("###50", imgui.ImVec2(7, 15), true) -- ножка
      imgui.EndChild()

      imgui.SameLine()

      imgui.SetCursorPos(imgui.ImVec2(327, 23))
      imgui.BeginChild("###51", imgui.ImVec2(7, 15), true) -- ножка
      imgui.EndChild()

      imgui.SetCursorPos(imgui.ImVec2(151, 1))
      imgui.BeginChild("###60", imgui.ImVec2(200, 30), true) -- маркировка/доклад

        imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 10)
          imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 0.49, 2.09, 0.25))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.89, 0.25, 0.00, 0.95))
              imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(2.35, 2.35, 2.25, 0.95))

                imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(0.00, 0.49, 2.09, 0.25))
                  imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.38, 0.38, 0.38, 0.30))
                      imgui.SetCursorPos(imgui.ImVec2(7, 4))
                      imgui.BeginChild("###64", imgui.ImVec2(120, 22), true)

                        imgui.PushItemWidth(130)
                        imgui.SetCursorPos(imgui.ImVec2(6, 1))
                        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
                          imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
                            if imgui.Combo("###018", table_imgui[15], {
                              u8"10-4",
                              u8"10-5",
                              u8"10-6",
                              u8"10-7",
                              u8"911",
                              u8"10-14",
                              u8"10-20",
                              u8"10-55",
                              u8"10-66",
                              u8"Скорая",
                              u8"Машина",
                            }) then
                              if table_imgui[15].v == 0 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: IO-4, RFR, over.") --1
                              elseif table_imgui[15].v == 1 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: IO-5, RFR, over.") --2
                              elseif table_imgui[15].v == 2 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: IO-6, RFR, over.") --3
                              elseif table_imgui[15].v == 3 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: IO-7, RFR, over.") --4
                              elseif table_imgui[15].v == 4 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: принял последний вызов, направляюсь по коду 3, nRFR, over.") --5
                              elseif table_imgui[15].v == 5 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: нужна транспортировка, нахожусь в " .. rajon() .. ", к-т " .. kvadrat() .. ", nRFR, over.") --6
                              elseif table_imgui[15].v == 6 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: все спокойно, нахожусь в " .. rajon() .. ", RFR, over.") --7
                              elseif table_imgui[15].v == 7 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: провожу трафик-стоп, номерной знак " .. getClosestPlayerId() .. ", нахожусь в " .. rajon() .. ", к-т " .. kvadrat() .. ", nRFR, over.") --8
                              elseif table_imgui[15].v == 8 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [All]: провожу IO-66, нахожусь в " .. rajon() .. ", номер " .. arg_su .. ", нужна помощь, nRFR, over.") --9
                              elseif table_imgui[15].v == 9 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: срочно требуется скорая помощь, нахожусь в " .. rajon() .. ", к-т " .. kvadrat() .. ", nRFR, over.") --10
                              elseif table_imgui[15].v == 10 then
                                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: брошенная машина на проезжей части, нужен эвакуатор в " .. rajon() .. ", к-т " .. kvadrat() .. ", RFR, over.") --11
                              end
                            end
                          imgui.PopStyleColor()
                        imgui.PopStyleColor()

                      imgui.EndChild()

                      imgui.SameLine()

                      imgui.SetCursorPos(imgui.ImVec2(130, 4))
                      imgui.BeginChild("###65", imgui.ImVec2(64, 22), true)

                        imgui.PushItemWidth(80)
                        imgui.SetCursorPos(imgui.ImVec2(0, 1))
                        imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
                          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
                            if imgui.Combo("###019", table_imgui[16], {"DISP", "All", TableMarking[3], TableMarking[4], TableMarking[5], TableMarking[6], TableMarking[7], TableMarking[8], TableMarking[9]}) then
                              if table_imgui[16].v == 0 then
                                table_imgui[4] = "DISP"
                              elseif table_imgui[16].v == 1 then
                                table_imgui[4] = "All"
                              elseif table_imgui[16].v == 2 then
                                table_imgui[4] = TableMarking[3]
                              elseif table_imgui[16].v == 3 then
                                table_imgui[4] = TableMarking[4]
                              elseif table_imgui[16].v == 4 then
                                table_imgui[4] = TableMarking[5]
                              elseif table_imgui[16].v == 5 then
                                table_imgui[4] = TableMarking[6]
                              elseif table_imgui[16].v == 6 then
                                table_imgui[4] = TableMarking[7]
                              elseif table_imgui[16].v == 7 then
                                table_imgui[4] = TableMarking[8]
                              elseif table_imgui[16].v == 8 then
                                table_imgui[4] = TableMarking[9]
                              end
                            end
                          imgui.PopStyleColor()
                        imgui.PopStyleColor()

                      imgui.EndChild()
                  imgui.PopStyleColor()
                imgui.PopStyleColor()

              imgui.PopStyleColor()
            imgui.PopStyleColor()
          imgui.PopStyleColor()
        imgui.PopStyleVar()

      imgui.EndChild()

      imgui.SetCursorPosY(34)
      imgui.SetCursorPosX(6)
      imgui.BeginChild("###44", imgui.ImVec2(350, 75), true) -- главное окно

        imgui.SetCursorPosY(5)
        imgui.SetCursorPosX(5)
        imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(0.00, 0.94, 0.03, 0.15))
          imgui.BeginChild("###61", imgui.ImVec2(220, 55), true)

            imgui.SetCursorPosY(6)
            imgui.SetCursorPosX(5)
            imgui.TextColored(imgui.ImVec4(0.92, 0.92, 0.92, 0.90), u8"Район:")

            imgui.SetCursorPosY(6)
            imgui.SetCursorPosX(62)
            imgui.TextColored(imgui.ImVec4(0.00, 2.04, 0.03, 0.90), u8(rajon()))

            imgui.SetCursorPosY(20)
            imgui.SetCursorPosX(5)
            imgui.TextColored(imgui.ImVec4(0.92, 0.92, 0.92, 0.90), u8"Квадрат:")

            imgui.SetCursorPosY(20)
            imgui.SetCursorPosX(62)
            imgui.TextColored(imgui.ImVec4(0.00, 2.04, 0.03, 0.90), u8(kvadrat()))

            imgui.SetCursorPosY(34)
            imgui.SetCursorPosX(5)
            imgui.TextColored(imgui.ImVec4(0.92, 0.92, 0.92, 0.90), u8"Юрисд:")

            imgui.SetCursorPosY(34)
            imgui.SetCursorPosX(62)
            imgui.TextColored(imgui.ImVec4(0.00, 2.04, 0.03, 0.90), u8(table_imgui[31]))
            -- imgui.SameLine()
            -- imgui.TextColored(imgui.ImVec4(0.00, 2.04, 0.03, 0.90), "X: ".. math.floor(x) .. " Y: " .. math.floor(y) .. " Z: " .. math.floor(z))

          imgui.EndChild()

          imgui.SameLine()

          imgui.SetCursorPosY(5)
          imgui.SetCursorPosX(230)
          imgui.BeginChild("###46", imgui.ImVec2(114, 28), true)

            imgui.SetCursorPosY(7)
            imgui.SetCursorPosX(10)
            imgui.TextColored(imgui.ImVec4(0.00, 2.04, 0.03, 0.90), u8(table_imgui[2] .. "-" .. table_imgui[3]))

            imgui.SameLine()

            imgui.SetCursorPosY(6)
            imgui.SetCursorPosX(57)
            imgui.TextColored(imgui.ImVec4(0.61, 0.61, 0.61, 0.70), u8"|")

            imgui.SameLine()

            imgui.SetCursorPosY(6)
            imgui.SetCursorPosX(56)
            imgui.TextColored(imgui.ImVec4(0.61, 0.61, 0.61, 0.70), u8"|")

            imgui.SetCursorPosY(7)
            imgui.SetCursorPosX(70)
            imgui.TextColored(imgui.ImVec4(0.00, 2.04, 0.03, 0.90), get_clock_pat(table_imgui[173].v))

          imgui.EndChild()
        imgui.PopStyleColor()
      
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.61, 1.61, 1.61, 0.65))
          imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 7)
            imgui.SetCursorPosY(41)
            imgui.SetCursorPosX(255)
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.89, 0.04, 0.04, 0.80))
              if imgui.Button("###00001", imgui.ImVec2(15, 15)) then
                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [All]: под огнем, срочно нужна помощь, нахожусь в " .. rajon() .. ", к-т " .. kvadrat() .. ", nRFR, over.")
              end
            imgui.PopStyleColor()

            imgui.SetCursorPosY(41)
            imgui.SetCursorPosX(284)
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(2.19, 1.97, 0.00, 0.80))
              if imgui.Button("###00002", imgui.ImVec2(15, 15)) then
                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [All]: нужна помощь ближайших патрулей, нахожусь в " .. rajon() .. ", к-т " .. kvadrat() .. ", nRFR, over.")
              end
            imgui.PopStyleColor()

            imgui.SetCursorPosY(41)
            imgui.SetCursorPosX(312)
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.25, 0.00, 1.89, 0.80))
              if imgui.Button("###00003", imgui.ImVec2(15, 15)) then
                sampSendChat("/r [" .. table_imgui[2] .. "-" .. table_imgui[3] .. "] - [" .. table_imgui[4] .. "]: IO-99 по ситуации, продолжаю патруль, район " .. rajon() .. ", RFR, over.")
              end
            imgui.PopStyleColor()
          imgui.PopStyleVar()
        imgui.PopStyleColor()

        imgui.SetCursorPosX(95)
        imgui.TextColored(imgui.ImVec4(0.98, 0.92, 0.94, 0.40), u8"Радиостанция YAPD-v.022®")

      imgui.EndChild()

      imgui.SameLine()

      imgui.SetCursorPosY(2)
      imgui.SetCursorPosX(16)
      imgui.BeginChild("###45", imgui.ImVec2(85, 29), true)

        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.38, 0.38, 0.38, 0.30))
            imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(0.00, 0.49, 2.09, 0.25))
              imgui.SetCursorPosY(5)
              imgui.SetCursorPosX(9)
              imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 4)
              imgui.BeginChild("###63", imgui.ImVec2(66, 18), true)

                imgui.SetCursorPosY(2)
                imgui.SetCursorPosX(7)
                imgui.TextColored(imgui.ImVec4(1.07, 1.08, 1.15, 1.0), os.date("%X"))

              imgui.EndChild()
              imgui.PopStyleVar()
            imgui.PopStyleColor()
        imgui.PopStyleColor()

      imgui.EndChild()
    
    imgui.PopStyleVar()
    imgui.End()
    imgui.PopStyleColor()
    imgui.PopStyleColor()
    imgui.PopStyleColor()
    imgui.PopStyleColor()
    imgui.PopStyleColor()
  else
    table_imgui[173].v = 0
	end

	if table_imgui[23].v then -- меню патруля
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(236, 409), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"              МЕНЮ ПАТРУЛЯ", table_imgui[23], imgui.WindowFlags.NoResize)

      imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
          imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
            imgui.BeginChild("###33", imgui.ImVec2(220, 150), true)

              imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"            Общая информация")

              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.30))   
              imgui.Separator()
              imgui.PopStyleColor()   

              imgui.SetCursorPos(imgui.ImVec2(6, 31))
              imgui.TextColored(imgui.ImVec4(0.00, 1.02, 0.14, 1.0), u8"Ник:")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(94, 31))
              imgui.TextColored(imgui.ImVec4(1.35, 1.43, 1.34, 1.0), u8:decode(mainSetting.setting[1]))

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(87, 33))
              imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.90), u8"__________________")
              imgui.SetCursorPos(imgui.ImVec2(5, 50))
              imgui.TextColored(imgui.ImVec4(0.00, 1.02, 0.14, 1.0), u8"Департамент:")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(94, 52))
              imgui.TextColored(imgui.ImVec4(1.35, 1.43, 1.34, 1.0), mainSetting.setting[9])

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(87, 53))
              imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.90), u8"__________________")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(5, 70))
              imgui.TextColored(imgui.ImVec4(0.00, 1.02, 0.14, 1.0), u8"Должность:")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(94, 72))
              imgui.TextColored(imgui.ImVec4(1.35, 1.43, 1.34, 1.0), u8:decode(mainSetting.setting[2]))

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(87, 73))
              imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.90), u8"__________________")
              imgui.SetCursorPos(imgui.ImVec2(5, 90))
              imgui.TextColored(imgui.ImVec4(0.35, 2.07, 0.23, 1.0), u8"Маркировка:")

              imgui.SameLine()

              imgui.SetCursorPosX(95)
              imgui.TextColored(imgui.ImVec4(1.35, 1.43, 1.34, 1.0), u8(table_imgui[2]))

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(87, 93))
              imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.90), u8"__________________")
              imgui.SetCursorPos(imgui.ImVec2(5, 110))
              imgui.TextColored(imgui.ImVec4(0.35, 2.07, 0.23, 1.0), u8"Номер:")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(94, 111))
              imgui.TextColored(imgui.ImVec4(1.35, 1.43, 1.34, 1.0), u8(table_imgui[3]))

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(87, 113))
              imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.90), u8"__________________")
              imgui.SetCursorPos(imgui.ImVec2(5, 130))
              imgui.TextColored(imgui.ImVec4(0.35, 2.07, 0.23, 1.0), u8"Время:")

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(94, 132))
              imgui.TextColored(imgui.ImVec4(1.35, 1.43, 1.34, 1.0), os.date("%X") .. " / " .. get_clock_pat(table_imgui[173].v))

              imgui.SameLine()

              imgui.SetCursorPos(imgui.ImVec2(87, 133))
              imgui.TextColored(imgui.ImVec4(0.40, 0.40, 0.40, 0.90), u8"__________________")

            imgui.EndChild()

            imgui.SetCursorPos(imgui.ImVec2(8, 184))
            imgui.BeginChild("###34", imgui.ImVec2(220, 217), true)
              imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"             Настройки патруля")

              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.30)) 
              imgui.Separator()
              imgui.PopStyleColor() 

              if imgui.Button(u8"Начать", imgui.ImVec2(98, 25)) then
                table_imgui[205] = not table_imgui[205]
              end

              imgui.SameLine()

              if imgui.Button(u8"Закончить", imgui.ImVec2(98, 25)) then
                if table_imgui[174].v then
                  table_imgui[204] = not table_imgui[204]
                else
                  sampAddChatMessage("Вы не начинали патруль, чтобы его закончить.", -1)
                end
              end

              if table_imgui[205] then
                if imgui.Button(u8"Доклад", imgui.ImVec2(58, 25)) then
                  sampAddChatMessage("{696969} >| {1adb6e}Убрать/показать курсор  \"{ff692e} Х {1adb6e}\".", -1)
                  table_imgui[174].v = true
                  table_imgui[205] = not table_imgui[205]
                  if table_imgui[174].v and table_imgui[88].v == "" and table_imgui[87].v == "" and table_imgui[86].v == "" then -- один 
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to [DISP]: 10-2 как " .. table_imgui[2] .. "-" .. table_imgui[3] .. ", RFR, over.")
                  elseif table_imgui[174].v and table_imgui[88].v ~= "" and table_imgui[87].v == "" and table_imgui[86].v == "" then -- 2
                    threads_units:run(table_imgui[88].v)
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to DISP: 10-2 как " .. table_imgui[2] .. "-" .. table_imgui[3] .. ", в составе [" .. table_imgui[6] .. "], RFR, over.")
                  elseif table_imgui[174].v and table_imgui[88].v ~= "" and table_imgui[87].v ~= "" and table_imgui[86].v == "" then --3
                    threads_units:run(table_imgui[88].v, table_imgui[87].v)
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to DISP: 10-2 как " .. table_imgui[2] .. "-" .. table_imgui[3] .. ", в составе [" .. table_imgui[6] .. ", "  .. table_imgui[9] .. "], RFR, over.")
                  elseif table_imgui[174].v and table_imgui[88].v ~= "" and table_imgui[87].v ~= "" and table_imgui[86].v ~= "" then --4
                    threads_units:run(table_imgui[88].v, table_imgui[87].v, table_imgui[86].v)
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to DISP: 10-2 как " .. table_imgui[2] .. "-" .. table_imgui[3] .. ", в составе [" .. table_imgui[6] .. ", "  .. table_imgui[9] .. ", "  .. table_imgui[7] .. "], RFR, over.")
                  else
                    sampAddChatMessage("{696969} >| {1adb6e}Вы что-то неуказали.", -1)
                  end
                end

                imgui.SameLine()

                if imgui.Button(u8"Без", imgui.ImVec2(32, 25)) then
                  threads_units:run(table_imgui[88].v, table_imgui[87].v, table_imgui[86].v)
                  table_imgui[174].v = true
                  table_imgui[205] = not table_imgui[205]
                  sampAddChatMessage("{696969} >| {1adb6e}Убрать/показать курсор  \"{ff692e} Х {1adb6e}\".", -1)
                end
              end

              if table_imgui[204] then
                imgui.SetCursorPos(imgui.ImVec2(114, 59))
                if imgui.Button(u8"Доклад", imgui.ImVec2(58, 25)) then
                  if table_imgui[174].v and table_imgui[88].v == "" and table_imgui[87].v == "" and table_imgui[86].v == "" then --1
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to [DISP]: 10-2R, освобождаю " .. table_imgui[2] .. "-" .. table_imgui[3] .. ", nRFR, over. ")
                    table_imgui[174].v = false
                    table_imgui[204] = not table_imgui[204]
                  elseif table_imgui[174].v and table_imgui[88].v ~= "" and table_imgui[87].v == "" and table_imgui[86].v == "" then --2
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to [DISP]: 10-2R в составе [" .. table_imgui[6] .. "], освобождаю " .. table_imgui[2] .. "-" .. table_imgui[3] .. ", nRFR, over.")
                    table_imgui[174].v = false
                    table_imgui[204] = not table_imgui[204]
                  elseif table_imgui[174].v and table_imgui[88].v ~= "" and table_imgui[87].v ~= "" and table_imgui[86].v == "" then --3
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to [DISP]: 10-2R в составе [" .. table_imgui[6] .. ", "  .. table_imgui[9] .. "], освобождаю " .. table_imgui[2] .. "-" .. table_imgui[3] .. ", nRFR, over.")
                    table_imgui[174].v = false
                    table_imgui[204] = not table_imgui[204]
                  elseif table_imgui[174].v and table_imgui[88].v ~= "" and table_imgui[87].v ~= "" and table_imgui[86].v ~= "" then --4
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to [DISP]: 10-2R в составе [" .. table_imgui[6] .. ", "  .. table_imgui[9] .. ", "  .. table_imgui[7] .. "], освобождаю " .. table_imgui[2] .. "-" .. table_imgui[3] .. ", nRFR, over.")
                    table_imgui[174].v = false
                    table_imgui[204] = not table_imgui[204]
                  end
                  table_imgui[88].v, table_imgui[87].v, table_imgui[86].v = "", "", ""
                end

                imgui.SameLine()

                if imgui.Button(u8"Без", imgui.ImVec2(32, 25)) then
                  table_imgui[174].v = false
                  table_imgui[204] = not table_imgui[204]
                  table_imgui[88].v, table_imgui[87].v, table_imgui[86].v = "", "", ""
                end
              end

              imgui.PushItemWidth(28)
              imgui.InputText(u8"Первый напарник", table_imgui[88])

              imgui.SameLine()

              imgui.SetCursorPosX(148)
              imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.58), "(ID)")

              imgui.InputText(u8"Второй напарник", table_imgui[87])

              imgui.SameLine()

              imgui.SetCursorPosX(148)
              imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.58), "(ID)")

              imgui.InputText(u8"Третий напарник", table_imgui[86])

              imgui.SameLine()

              imgui.SetCursorPosX(148)
              imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.58), "(ID)")

              imgui.PushItemWidth(100)
              imgui.Combo("###020", table_imgui[206], {u8"L (Lincoln)",
              u8"A (Adam)",
              u8"M (Mary)",
              u8"D (David)",
              u8"K (King)",
              u8"Air",
              u8"E (Edward)",})
              if table_imgui[206].v == 0 then
                table_imgui[2] = "L"
                table_imgui[206].v = -1
              elseif table_imgui[206].v == 1 then
                table_imgui[2] = "A"
                table_imgui[206].v = -1
              elseif table_imgui[206].v == 2 then
                table_imgui[2] = "M"
                table_imgui[206].v = -1
              elseif table_imgui[206].v == 3 then
                table_imgui[2] = "D"
                table_imgui[206].v = -1
              elseif table_imgui[206].v == 4 then
                table_imgui[2] = "K"
                table_imgui[206].v = -1
              elseif table_imgui[206].v == 5 then
                table_imgui[2] = "Air"
                table_imgui[206].v = -1
              elseif table_imgui[206].v == 6 then
                table_imgui[2] = "E"
                table_imgui[206].v = -1
              end

              imgui.SameLine()

              imgui.Combo("###021", table_imgui[207], {u8"1",
              u8"2",
              u8"3",
              u8"4",
              u8"5",
              u8"6",
              u8"7",
              u8"8",
              u8"9",
              u8"10",})
              if table_imgui[207].v == 0 then
                table_imgui[3] = "1"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 1 then
                table_imgui[3] = "2"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 2 then
                table_imgui[3] = "3"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 3 then
                table_imgui[3] = "4"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 4 then
                table_imgui[3] = "5"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 5 then
                table_imgui[3] = "6"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 6 then
                table_imgui[3] = "7"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 7 then
                table_imgui[3] = "8"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 8 then
                table_imgui[3] = "9"
                table_imgui[207].v = -1
              elseif table_imgui[207].v == 9 then
                table_imgui[3] = "10"
                table_imgui[207].v = -1
              end
              
              imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.30))   
              imgui.Separator()
              imgui.PopStyleColor()
              
              imgui.SetCursorPos(imgui.ImVec2(128, 188))
              imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.13, 0.13, 0.13, 0.90))
              imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.13, 0.62, 1.61, 0.35))
              if imgui.Button(u8"Перезагрузка", imgui.ImVec2(88, 24)) then
                thread_reload:run()
              end
              imgui.PopStyleColor()
              imgui.PopStyleColor()

            imgui.EndChild()

          imgui.PopStyleVar()
        imgui.PopStyleColor()
      imgui.PopStyleVar()
		imgui.End()
	end

	if table_imgui[28].v then -- меню диспетчера

		dispetch()
		dispetch_r()

    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(1000, 807), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"                                                                                                     МЕНЮ ДИСПЕТЧЕРА|Your Assistent  [Beta]", table_imgui[28], imgui.WindowFlags.NoResize)

    imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
      imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.56, 0.56, 0.56, 0.50))
        imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.23, 0.31, 1.38, 0.65))
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.30, 0.34, 0.33, 1.00))
          imgui.BeginChild("###35", imgui.ImVec2(350, 427), true)

            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"                                  ГЛАВНОЕ ОКНО")

            imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(2.19, 2.19, 2.19, 0.35))   
            imgui.Separator()

            if imgui.Button(u8"Общий сбор", imgui.ImVec2(165, 20)) then
              if table_imgui[36] == "Принято" then
                sampSetChatInputEnabled(true)
                sampSetChatInputText("/r [DISP] to [All]: Всему составу завершить дела и прибыть на общий строй!")
              else
                sampAddChatMessage("{696969} >| {1adb6e}Вы не приняли дежурство.", -1)
              end
            end

            imgui.SameLine()

            if imgui.Button(u8"Приоритетный Код-0", imgui.ImVec2(161, 20)) then
              if table_imgui[36] == "Принято" then
                sampSetChatInputEnabled(true)
                sampSetChatInputText("/r [DISP] to [All]: Всем юнитам! Объявлен Код-0, направляйтесь в")
              else
                sampAddChatMessage("{696969} >| {1adb6e}Вы не приняли дежурство.", -1)
              end
            end

            if imgui.Button(u8"Обьявлен 10-66", imgui.ImVec2(165, 20)) then
              if table_imgui[36] == "Принято" then
                sampSetChatInputEnabled(true)
                sampSetChatInputText("/r [DISP] to [All]: Объявлен IO-66, всем свободным патрулям направится в")
              else
                sampAddChatMessage("{696969} >| {1adb6e}Вы не приняли дежурство.", -1)
              end
            end

            imgui.SameLine()

            if imgui.Button(u8"Приоритетный Код-1", imgui.ImVec2(161, 20)) then
              if table_imgui[36] == "Принято" then
                sampSetChatInputEnabled(true)
                sampSetChatInputText("/r [DISP] to [All]: Объявлен Код-1, юнит в бедственном положении, направляйтесь в")
              else
                sampAddChatMessage("{696969} >| {1adb6e}Вы не приняли дежурство.", -1)
              end
            end

            if imgui.Button(u8"Погоня 10-57VICTOR", imgui.ImVec2(165, 20)) then
              if table_imgui[36] == "Принято" then
                sampSetChatInputEnabled(true)
                sampSetChatInputText("/r [DISP] to [All]: Свободные юниты, подключайтесь к погоне по коду 3, юнит движется в сторону ")
              else
                sampAddChatMessage("{696969} >| {1adb6e}Вы не приняли дежурство.", -1)
              end
            end

            imgui.SameLine()

            if imgui.Button(u8"Погоня 10-57FOXROT", imgui.ImVec2(161, 20)) then
              if table_imgui[36] == "Принято" then
                sampSetChatInputEnabled(true)
                sampSetChatInputText("/r [DISP] to [All]: Свободные юниты, подключайтесь к пешей погоне, юнит движется в ")
              else
                sampAddChatMessage("{696969} >| {1adb6e}Вы не приняли дежурство.", -1)
              end
            end

            imgui.Separator()
            imgui.PopStyleColor()

            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Code 0")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- самый приоритетный вызов, необходима\n  немедленная поддержка.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Code 1")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- сотрудник в бедственном положении.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Code 2")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- выезд на приоритетный вызов.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Code 3")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- выезд на срочный вызов.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Code 4")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- помощь не требуется.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Code 4 - ADAM")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- помощь не требуется, подозреваемый\n  потерян.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Code 6")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- задержка на месте.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Code 7")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- перерыв на обед.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Сode Robert-Rifle")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- офицеру требуется штурмовая\n  винтовка.")
            imgui.TextColored(imgui.ImVec4(0.07, 0.23, 1.30, 1.0), u8"Сode Robert-Slug")
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"- рфицеру требуется дробовик.")

          imgui.EndChild()

          imgui.SetCursorPos(imgui.ImVec2(830, 93))
          imgui.BeginChild("###36", imgui.ImVec2(164, 362), true)

            imgui.SetCursorPos(imgui.ImVec2(1, 71))

            imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(2.19, 2.19, 2.19, 0.35))   
            imgui.Separator()

            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"            ДЕЙСТВИЯ")
            
            imgui.Separator()
            imgui.PopStyleColor()

            local doklas_disp = {
              "Принято/10-4",
              "/r [DISP] to [" .. table_imgui[100] .. "]: Информация принята, over.",
              "На связь/10-20",
              "/r [DISP] to [" .. table_imgui[100] .. "]: Выйдите на связь, доложите ситуацию и 10-20, over.",
              "Направить 911",
              "/r [DISP] to [" .. table_imgui[100] .. "]: Направляйтесь на место вызова 911, я закрепляю вас за ним, over.",
              "Направить 10-66",
              "/r [DISP] to [" .. table_imgui[100] .. "]: Двигайтесь к месту проведения трафик-стопа повышенной опасности, обеспечьте поддержку юниту, over.",
              "Направить 10-55",
              "/r [DISP] to [" .. table_imgui[100] .. "]: Двигайтесь к месту проведения трафик-стопа, обеспечьте поддержку юниту, over.",
              "Направить Код-1",
              "/r [DISP] to [" .. table_imgui[100] .. "]: Двигайтесь к месту, где был объявлен Код 1, юнит в бедственном положении, over",
              "Направить Код-3",
              "/r [DISP] to [" .. table_imgui[100] .. "]: Двигайтесь к месту, где был объявлен Код 3, приоритетный вызов, over"
            }

            for i = 1, #doklas_disp, 2 do
              if imgui.Button(u8(doklas_disp[i]), imgui.ImVec2(150, 20)) then
                if table_imgui[99] ~= "-" and table_imgui[100] ~= "-" and table_imgui[101] == "1" then
                  sampSendChat(doklas_disp[i+1])
                  table_imgui[101] = "2"
                elseif table_imgui[99] ~= "-" and table_imgui[100] ~= "-" and table_imgui[101] == "2" then
                  sampSendChat(doklas_disp[i+1] .. " *повторяя*")
                  table_imgui[101] = "1"
                elseif table_imgui[99] == "-" or table_imgui[100] == "-" then
                  sampAddChatMessage("{696969} >| {1adb6e}Вы не приняли дежурство/не выбрали активный айди/маркировку.", -1)
                end
              end
            end

            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1.66, 0.11, 0.03, 0.50))
              imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.70, 0.15, 0.10, 0.70))
                if imgui.Button(u8"Очистить", imgui.ImVec2(150, 20)) then
                  table_imgui[101] = "1"
                  table_imgui[102] = "1"
                  table_imgui[103] = "1"
                  table_imgui[104] = "1"
                  table_imgui[105] = "1"
                  table_imgui[99] = "-"
                  table_imgui[100] = "-"
                end
              imgui.PopStyleColor()
            imgui.PopStyleColor()

            imgui.SetCursorPos(imgui.ImVec2(24, 325))
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.70), u8"Допустимо двойное\n         нажатие.")

          imgui.EndChild()

          imgui.SetCursorPos(imgui.ImVec2(363, 93))
          imgui.BeginChild("###37", imgui.ImVec2(462, 362), true)

            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.19, 0.20, 0.99, 0.50))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.70, 0.15, 0.10, 0.30))
            imgui.SetCursorPos(imgui.ImVec2(37, 9))
            if imgui.Button(u8"Заступить на дежурство", imgui.ImVec2(150, 23)) then
              table_imgui[34] = not table_imgui[34]
              table_imgui[35] = false
            end
            if table_imgui[34] then
              imgui.SetCursorPos(imgui.ImVec2(7, 37))
              if imgui.Button(u8"Доклад", imgui.ImVec2(100, 23)) then
                if table_imgui[36] ~= "Принято" then
                  sampSendChat("/r В ПСУ авторизовался Диспетчер:  "  .. table.concat(table_imgui, ".", 93, 94) .. ". На дежурство заступил активный DISP.")
                else
                  sampAddChatMessage("{696969} >| {1adb6e}Вы уже приняли дежурство.", -1)
                end
                table_imgui[36] = "Принято"
                table_imgui[37] = imgui.ImVec4(0.24, 1.10, 0.26, 1.0)
                table_imgui[34] = not table_imgui[34]
              end
              imgui.SameLine()
              if imgui.Button(u8"Без доклада", imgui.ImVec2(100, 23)) then
                if table_imgui[36] ~= "Принято" then
                  table_imgui[36] = "Принято"
                  table_imgui[37] = imgui.ImVec4(0.24, 1.10, 0.26, 1.0)
                  table_imgui[34] = not table_imgui[34]
                  sampAddChatMessage("{696969} >| {1adb6e}Активирована клавиша \"{ff692e}G{1adb6e}\" (специально для диспетчера).", -1)
                else
                  sampAddChatMessage("{696969} >| {1adb6e}Вы уже приняли дежурство.", -1)
                end
              end
            end
            imgui.SameLine()
            imgui.SetCursorPos(imgui.ImVec2(270, 9))
            if imgui.Button(u8"Сдать дежурство", imgui.ImVec2(150, 23)) then
              table_imgui[35] = not table_imgui[35]
              table_imgui[34] = false
            end
            if table_imgui[35] then
              imgui.SetCursorPos(imgui.ImVec2(240, 37))
              if imgui.Button(u8"Доклад", imgui.ImVec2(100, 23)) then
                if table_imgui[36] == "Принято" then
                  sampSendChat("/r Диспетчер:  " .. table.concat(table_imgui, ".", 93, 94) .. ", сдал дежурство и пожелал удачи всем патрулям. ")
                  table_imgui[36] = "Сдано"
                  table_imgui[37] = imgui.ImVec4(2.30, 0.30, 0.30, 1.0)
                  table_imgui[35] = not table_imgui[35]
                else
                  sampAddChatMessage("{696969} >| {1adb6e}Вы сдали/не принимали дежурство.", -1)
                end
              end
              imgui.SameLine()
              if imgui.Button(u8"Без доклада", imgui.ImVec2(100, 23)) then
                if table_imgui[36] == "Принято" then
                  table_imgui[36] = "Сдано"
                  table_imgui[37] = imgui.ImVec4(2.30, 0.30, 0.30, 1.0)
                  table_imgui[35] = not table_imgui[35]
                else
                  sampAddChatMessage("{696969} >| {1adb6e}Вы сдали/не принимали дежурство.", -1)
                end
              end
            end
            imgui.PopStyleColor()
            imgui.PopStyleColor()

            if table_imgui[36] ~= "Принято" then
              for i = 39, 68, 1 do 
                table_imgui[i] = "---"
              end
            end

            imgui.SetCursorPos(imgui.ImVec2(370, 71))

            imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(2.19, 2.19, 2.19, 0.35))   
              imgui.Separator()

              imgui.Columns(3, "004", true)
              imgui.TextColored(imgui.ImVec4(0.00, 1.25, 0.06, 0.80), u8"              Звание")
              imgui.NextColumn()
              imgui.TextColored(imgui.ImVec4(0.00, 1.25, 0.06, 0.80), u8"                Айди")
              imgui.NextColumn()
              imgui.TextColored(imgui.ImVec4(0.00, 1.25, 0.06, 0.80), u8"          Маркировка")
              imgui.NextColumn()

              imgui.Separator()
            imgui.PopStyleColor()
-- "39 40 41 - 42 43 44 - 45 46 47 - 48 49 50 - 51 52 53 - 54 55 56 - 57 58 59 - 60 61 62 - 63 64 65 - 66 67 68"

            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, -0.10, 0.00, 0.95))
              for i = 39, 66, 3 do
                imgui.Text(u8(table_imgui[i]))
                imgui.NextColumn()
                if imgui.Button(u8(table_imgui[i+1]), imgui.ImVec2(140, 22)) then -- айди
                  table_imgui[99] = table_imgui[i+1]
                end
                imgui.NextColumn()
                if imgui.Button(u8(table_imgui[i+2]), imgui.ImVec2(140, 22)) then -- марк
                  table_imgui[100] = table_imgui[i+2]
                end
                imgui.NextColumn()
              end
            imgui.PopStyleColor()

          imgui.EndChild()

          imgui.SetCursorPos(imgui.ImVec2(8, 460))
          imgui.BeginChild("###38", imgui.ImVec2(984, 340), true)

            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"                                                                                                                           ЛОГ РАЦИИ")

            imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(2.19, 2.19, 2.19, 0.35))   
            imgui.Separator()
            imgui.PopStyleColor()

            for i = 1, 17 do
              if i >= 10 then
                imgui.SetCursorPosX(1)
              end
              imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 0.50), " [" .. i .."] ")
              imgui.SameLine()
              imgui.TextColored(imgui.ImVec4(0.19, 0.40, 2.32, 1.0), u8(table_disp[i]))
            end
        
          imgui.EndChild()
        imgui.PopStyleColor()
        imgui.PopStyleColor()
        imgui.PopStyleVar()
      imgui.PopStyleColor()
    imgui.PopStyleVar()

    imgui.SetCursorPos(imgui.ImVec2(365, 29))
		imgui.TextColored(imgui.ImVec4(0.82, 0.80, 0.80, 1.0), u8"Время:")
		imgui.SameLine()
    imgui.SetCursorPosX(409)
		imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 1.0), os.date("%X"))
    imgui.SetCursorPos(imgui.ImVec2(480, 29))
		imgui.TextColored(imgui.ImVec4(0.82, 0.80, 0.80, 1.0), u8"Департамент:")
		imgui.SameLine()
		imgui.TextColored(imgui.ImVec4(0.06, 0.46, 1.91, 1.0), mainSetting.setting[9])
    imgui.SetCursorPos(imgui.ImVec2(630, 29))
		imgui.TextColored(imgui.ImVec4(0.82, 0.80, 0.80, 1.0), u8"Статус дежурства:")
		imgui.SameLine()
		imgui.TextColored(table_imgui[37], u8(table_imgui[36]))
		imgui.SameLine()
    imgui.SetCursorPosX(825)
		imgui.TextColored(imgui.ImVec4(0.82, 0.80, 0.80, 1.0), u8"  Время дежурства:")
		imgui.SameLine()
		imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 1.0), get_clock(table_imgui[97].v))
    imgui.SetCursorPos(imgui.ImVec2(365, 69))
		imgui.TextColored(imgui.ImVec4(0.82, 0.80, 0.80, 1.0), u8"Активная маркировка:")
		imgui.SameLine()
		imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 1.0), table_imgui[100])
    imgui.SetCursorPos(imgui.ImVec2(580, 69))
		imgui.TextColored(imgui.ImVec4(0.82, 0.80, 0.80, 1.0), u8"Активный айди:")
		imgui.SameLine()
		imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 1.0), table_imgui[99])
		imgui.End()
		if table_imgui[36] == "Принято" then
			table_imgui[97].v = table_imgui[97].v + 1 
		else
			table_imgui[97].v = 0
		end
	end

	if table_imgui[106].v then -- меню поста
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(400, 200), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"                                       МЕНЮ ПОСТА", table_imgui[106], imgui.WindowFlags.NoResize)
      imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.25))
        imgui.Separator()

        imgui.Columns(2, "005", true)

          imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 1.00), u8"      ОСНОВНЫЕ НАСТРОЙКИ")

          imgui.NextColumn()

          imgui.TextColored(imgui.ImVec4(2.55, 2.55, 2.55, 1.00), u8"  СПЕЦИАЛЬНЫЕ НАСТРОЙКИ")

          imgui.Separator()

          imgui.NextColumn()

          imgui.SetCursorPos(imgui.ImVec2(36, 61))
          imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"Таймер:")

          imgui.SameLine()

          imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
            imgui.PushItemWidth(70)
            imgui.SetCursorPos(imgui.ImVec2(93, 60))
            imgui.InputText(u8"##0015", table_imgui[107]) -- таймер

            imgui.SameLine()

            imgui.SetCursorPos(imgui.ImVec2(167, 59))
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"мин.")
            
            imgui.SetCursorPos(imgui.ImVec2(25, 90))
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"Название:")
            
            imgui.SameLine()

            imgui.PushItemWidth(70)
            imgui.InputText(u8"##0016", table_imgui[109]) -- название поста

            if table_imgui[108].v then
              table_imgui[110] = "2"
            else
              table_imgui[110] = "1"
            end

            imgui.NextColumn()

            imgui.SetCursorPos(imgui.ImVec2(234, 60))
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"Доклад посередине:")

            imgui.SameLine()

            imgui.SetCursorPos(imgui.ImVec2(362, 60))
            imgui.Checkbox("###09", table_imgui[108]) -- доклад посередине
            
            imgui.SetCursorPos(imgui.ImVec2(215, 90))
            imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), u8"Скриншот при докладе:")

            imgui.SameLine()

            imgui.Checkbox("###10", table_imgui[111]) -- скриншот

          imgui.Columns(1)

          imgui.Separator()

        imgui.PopStyleVar()

        if table_imgui[111].v then
          table_imgui[112] = "2"
        else
          table_imgui[112] = "1"
        end

        imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)
          imgui.SetCursorPos(imgui.ImVec2(35, 136))
          if imgui.Button(u8"Заступить", imgui.ImVec2(150, 25)) then
            if table_imgui[107].v ~= "" and table_imgui[109].v ~= "" then
              thread_post = lua_thread.create(func_spost)
            else
              sampAddChatMessage("{696969} >| {1adb6e}Чтобы заступить на пост - нужно указать время и название поста.", -1)
            end
          end

          imgui.SameLine()
          
          imgui.SetCursorPos(imgui.ImVec2(214, 136))
          if imgui.Button(u8"Прервать", imgui.ImVec2(150, 25)) then
            if table_imgui[107].v ~= "" and table_imgui[109].v ~= "" then
              thread_post:terminate()
              table_imgui[107].v = ""
              table_imgui[109].v = ""
              table_imgui[111].v = false
              table_imgui[108].v = false
            else
              sampAddChatMessage("{696969} >| {1adb6e}Вы не заступили на пост.", -1)
            end
          end
        imgui.PopStyleVar()

        imgui.SetCursorPos(imgui.ImVec2(169, 174))
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 3)
          imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.35))
            imgui.BeginChild("###39", imgui.ImVec2(59, 21), true)

              imgui.SetCursorPos(imgui.ImVec2(4, 3))
              imgui.TextColored(imgui.ImVec4(0.71, 0.71, 0.70, 1.0), os.date("%X"))

            imgui.EndChild()
          imgui.PopStyleColor()
        imgui.PopStyleVar()
        imgui.SetCursorPos(imgui.ImVec2(3, 185))
        imgui.Separator()
      imgui.PopStyleColor()
		imgui.End()
	end

  if table_imgui[30].v then -- окно юрисдикция
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Once, imgui.ImVec2(-3.5, 1.0))
    imgui.SetNextWindowSize(imgui.ImVec2(200, 290), imgui.Cond.FirstUseEver)
    imgui.Begin(u8"        РАЦИЯ ДЕПАРТАМЕНТА", table_imgui[30], imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
      imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 5)
        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0.98, 0.92, 0.94, 0.30))
          imgui.BeginChild("###40", imgui.ImVec2(184, 255), true)

            imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(0.98, 0.92, 0.94, 0.30))
              imgui.Separator()

              imgui.SetCursorPos(imgui.ImVec2(22, 11))
              imgui.Text(u8"Нарушена юрисдикция:")

              imgui.SetCursorPos(imgui.ImVec2(54, 32))
              imgui.TextColored(imgui.ImVec4(0.46, 0.46, 0.48, 0.60), "||")

              imgui.SameLine()

              imgui.TextColored(imgui.ImVec4(0.32, 0.29, 2.09, 1.0), u8(table_imgui[31]))

              imgui.SameLine()

              imgui.TextColored(imgui.ImVec4(0.46, 0.46, 0.48, 0.60), "||")

              imgui.SetCursorPos(imgui.ImVec2(16, 51))
              imgui.Text(u8"Желаете сделать доклад?")

              imgui.Separator()
            imgui.PopStyleColor()

            imgui.SetCursorPos(imgui.ImVec2(25, 81))
            imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 3)

              for i = 19, 25 do
                imgui.SetCursorPosX(25)
                if imgui.Button("" .. mainDepart[i].name, imgui.ImVec2(135, 20)) then
                  if not table_imgui[83].v then
                    sampSendChat("/d [" .. u8:decode(mainSetting.setting[9]) .. "] - [" .. table_imgui[31] .. "]: " .. u8:decode(mainDepart[i][1]))
                  elseif table_imgui[83].v then
                    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] to [All]: [" .. u8:decode(mainSetting.setting[9]) .. "] - [" .. table_imgui[31] .. "]: " .. u8:decode(mainDepart[i][1]))
                  end
                  table_imgui[30].v = false
                end
              end

            imgui.PopStyleVar()

          imgui.EndChild()
        imgui.PopStyleColor()
      imgui.PopStyleVar()
    imgui.End()
  end

end

function reload_script()
  table_imgui[23].v = not table_imgui[23].v
  sampAddChatMessage("{696969} >| {1adb6e}Перезагрузка. {696969}|<", -1)
  wait(250)
  thisScript():reload()
end

function func_spost()
	if table_imgui[109].v and table_imgui[107].v and table_imgui[110] == "1" then
		sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] - [DISP]: Заступаю на дежурство, пост " .. u8:decode(table_imgui[109].v) .. ", over.")
		wait(1000)
		sampSendChat("/time")
		wait(100)
		if table_imgui[112] == "2" then
			setVirtualKeyDown(vkey.VK_F8, true)
		  wait(100)
		  setVirtualKeyDown(vkey.VK_F8, false)
		end
		wait(1000)
		sampSendChat("/anims 89")
		wait(table_imgui[107].v * 60000) 
		sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] - [DISP]: Сдаю дежурство, пост " .. u8:decode(table_imgui[109].v) .. ", over.")
		wait(1000)
		sampSendChat("/time")
		wait(1000)
		if table_imgui[112] == "2" then
			setVirtualKeyDown(vkey.VK_F8, true)
		  wait(100)
		  setVirtualKeyDown(vkey.VK_F8, false)
		end
		wait(1000)
		setVirtualKeyDown(vkey.VK_RETURN, true)
		wait(100)
		setVirtualKeyDown(vkey.VK_RETURN, false)
	elseif table_imgui[108].v and table_imgui[109].v and table_imgui[107].v and table_imgui[110] == "2" then
		sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] - [DISP]: Заступаю на дежурство, пост " .. u8:decode(table_imgui[109].v) .. ". Следующий доклад через " .. table_imgui[107].v / 2 .. " минут, over.", -1)
		wait(1000)
		sampSendChat("/time")
		wait(100)
		if table_imgui[112] == "2" then
			setVirtualKeyDown(vkey.VK_F8, true)
		  wait(100)
		  setVirtualKeyDown(vkey.VK_F8, false)
		end
		wait(1000)
		sampSendChat("/anims 89")
		wait((table_imgui[107].v / 2) * 60000)
		sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] - [DISP]: Нахожусь на посту " .. u8:decode(table_imgui[109].v) .. ", over.")
		wait(1000)
		sampSendChat("/time")
		wait(1000)
		if table_imgui[112] == "2" then
			setVirtualKeyDown(vkey.VK_F8, true)
		  wait(100)
		  setVirtualKeyDown(vkey.VK_F8, false)
		end
		wait((table_imgui[107].v / 2) * 60000)
		sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] - [DISP]: Сдаю дежурство, пост " .. u8:decode(table_imgui[109].v) .. ", over.")
		wait(1000)
		sampSendChat("/time")
		wait(1000)
		if table_imgui[112] == "2" then
			setVirtualKeyDown(vkey.VK_F8, true)
		  wait(100)
		  setVirtualKeyDown(vkey.VK_F8, false)
		end
		wait(1000)
		setVirtualKeyDown(vkey.VK_RETURN, true)
		wait(100)
		setVirtualKeyDown(vkey.VK_RETURN, false)
	end
end

function PatrolUnits(id1, id2, id3)
  if id1 and not id2 and not id3 then
    table_imgui[6] = string.format("%s.%s", sampGetPlayerNickname(id1):match("(%u)%l+%p*(%a+)"))
  elseif id1 and id2 and not id3 then
    table_imgui[6] = string.format("%s.%s", sampGetPlayerNickname(id1):match("(%u)%l+%p*(%a+)"))
    table_imgui[9] = string.format("%s.%s", sampGetPlayerNickname(id2):match("(%u)%l+%p*(%a+)"))
  elseif id1 and id2 and id3 then
    table_imgui[6] = string.format("%s.%s", sampGetPlayerNickname(id1):match("(%u)%l+%p*(%a+)"))
    table_imgui[9] = string.format("%s.%s", sampGetPlayerNickname(id2):match("(%u)%l+%p*(%a+)"))
    table_imgui[7] = string.format("%s.%s", sampGetPlayerNickname(id3):match("(%u)%l+%p*(%a+)"))
  end
end

function event.onServerMessage(color, text)
  if text:find("Внимание! {FFFFFF}.+%[%d*%]{FF6347} был") and color == -10270721 then
    return false
  elseif table_imgui[174].v and color == 766526463 then
    cut_string_chat = text:match("[A-MO-Z]+[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?[%l]?%-[%d]+")
    MarkingChat()
  end
end

function event.onSendChat(msg)
  if msg:find("<chat_enabled>") then
    lua_thread.create(function()
      wait(5)
      sampSetChatInputEnabled(true)
    end)
    return false
  end
  if msg:find("<input_chat>") then
    local input_chat = string.match(msg, "<input_chat>%s*(.*)")
    lua_thread.create(function()
      wait(6)
      sampSetChatInputText(input_chat)
      setVirtualKeyDown(vkey.VK_SPACE, true)
    end)
    return false
  end
  if msg:find("<to>") then
    local mstag_to = msg:gsub("<to>", table_imgui[4])
    sampSendChat(mstag_to)
    return false
  end
  if msg:find("<marking_number>") then
    local mstag_marking = msg:gsub("<marking_number>", table_imgui[2] .. "-" .. table_imgui[3])
    sampSendChat(mstag_marking)
    return false
  end
  if msg:find("<city>") then
    local mstag_city = msg:gsub("<city>", table_imgui[229])
    sampSendChat(mstag_city)
    return false
  end
  if msg:find("<target_player>") then
    local mstag_target = msg:gsub("<target_player>", table_imgui[222])
    sampSendChat(mstag_target)
    return false
  end
  if msg:find("<wait_%d*>") then
    number_wait = string.match(msg, "<wait_(%d*)>")
    return false
  end
  if msg:find("<district>") then
    local mstag_town = msg:gsub("<district>", rajon())
    sampSendChat(mstag_town)
    return false
  end
  if msg:find("<square>") then
    local mstag_square = msg:gsub("<square>", kvadrat())
    sampSendChat(mstag_square)
    return false
  end
  if msg:find("<time>") then
    local mstag_time = msg:gsub("<time>", os.date("%X"))
    sampSendChat(mstag_time)
    return false
  end
  if msg:find("<date>") then
    local mstag_date = msg:gsub("<date>", os.date("%d/%m/%Y"))
    sampSendChat(mstag_date)
    return false
  end
  if msg:find("<target_id>") then
    local mstag_date = msg:gsub("<target_id>", table_imgui[19])
    sampSendChat(mstag_date)
    return false
  end
  if msg:find("<departament>") then
    local mstag_date = msg:gsub("<departament>", u8:decode(mainSetting.setting[9]))
    sampSendChat(mstag_date)
    return false
  end
  if msg:find("<phone>") then
    local mstag_date = msg:gsub("<phone>", u8:decode(mainSetting.setting[3]))
    sampSendChat(mstag_date)
    return false
  end
  if msg:find("<driver>") then
    local mstag_date = msg:gsub("<driver>", getClosestPlayerId())
    sampSendChat(mstag_date)
    return false
  end
  if msg:match("<myid>") then
  local mstag_to = msg:gsub("<myid>", ind)
  sampSendChat(mstag_to)
  return false
  end
end

function event.onSendCommand(command)
  if command:match("/frisk (.*)") then
    threads_command:run(2)
	elseif command:match("/take (.*)") then
		threads_command:run(1)
	elseif command:match("/pull (.*)") then
		threads_command:run(3)
	elseif command:match("/incar (.*) (.*)") then
		threads_command:run(4)
	elseif command:match("/arrest (.*)") then
		threads_command:run(5)
	elseif command:match("/gotome (.*)") then
		threads_command:run(6)
	elseif command:match("/ungotome (.*)") then
		threads_command:run(7)
	elseif command:match("/cuff (.*)") then
		threads_command:run(8)
	elseif command:match("/uncuff (.*)") then
		threads_command:run(9)
  elseif command:find("/su") then
    threads_command:run(11)
	elseif command:match("/unsu (.*) (.*) (.*)") then
		threads_command:run(10)
	elseif command:match("/clear (.*)") then
		threads_command:run(36)
	elseif command:match("/unmask (.*)") then
		threads_command:run(13)
	elseif command:find("/ticket") then
		threads_command:run(12)
  elseif command:match("/find (.*)") then
		threads_command:run(15)
  elseif command:find("/mask") then
		threads_command:run(16)
  elseif command:match("/bk (.*)") then
    threads_command:run(17)
  elseif command:match("/wanted (.*)") then
    threads_command:run(18)
  elseif command:match("/demoute (.*)") then
    threads_command:run(19)
  elseif command:match("/bot (.*)") then
    threads_command:run(20)
  elseif command:match("/unbag (.*)") then
    threads_command:run(21)
  elseif command:match("/untie (.*)") then
    threads_command:run(22)
  elseif command:match("/ungag (.*)") then
    threads_command:run(23)
  elseif command:find("/point") then
    threads_command:run(24)
  elseif command:match("/invite (.*)") then
    threads_command:run(25)
  elseif command:match("/uninvite (.*)") then
    threads_command:run(26)
  elseif command:match("/giverank (.*)") then
    threads_command:run(27)
  elseif command:match("/fwarn (.*)") then
    threads_command:run(28)
  elseif command:match("/fwarnoff (.*)") then
    threads_command:run(29)
  elseif command:match("/unfwarn (.*)") then
    threads_command:run(30)
  elseif command:match("/unfwarnoff (.*)") then
    threads_command:run(31)
  elseif command:match("/fmute (.*)") then
    threads_command:run(32)
  elseif command:match("/fmutes (.*)") then
    threads_command:run(33)
  elseif command:match("/funmute (.*)") then
    threads_command:run(34)
  elseif command:match("/premium (.*)") then
    threads_command:run(35)
  elseif command:match("/showbadge (.*)") then
    threads_command:run(37)
  elseif command:match("/.*(<phone>).*") then
    local mstag = command:gsub("<phone>", u8:decode(mainSetting.setting[3]))
    sampSendChat(mstag)
    return false
  elseif command:match("/.*(<driver>).*") then
    local mstag = command:gsub("<driver>", getClosestPlayerId())
    sampSendChat(mstag)
    return false
  elseif command:match("/.*(<departament>).*") then
    local mstag = command:gsub("<departament>", u8:decode(mainSetting.setting[9]))
    sampSendChat(mstag)
    return false
  elseif command:match("/.*(<target_id>).*") then
    local mstag_date = command:gsub("<target_id>", table_imgui[19])
    sampSendChat(mstag_date)
    return false
  elseif command:match("/.*(<date>).*") then
    local mstag_date = command:gsub("<date>", os.date("%d/%m/%Y"))
    sampSendChat(mstag_date)
    return false
  elseif command:match("/.*(<time>).*") then
    local mstag_time = command:gsub("<time>", os.date("%X"))
    sampSendChat(mstag_time)
    return false
  elseif command:match("/.*(<square>).*") then
    local mstag_square = command:gsub("<square>", kvadrat())
    sampSendChat(mstag_square)
    return false
  elseif command:match("/.*(<district>).*") then
    local mstag_town = command:gsub("<district>", rajon())
    sampSendChat(mstag_town)
    return false
  elseif command:match("/.*(<target_player>).*") then
    local mstag_target = command:gsub("<target_player>", table_imgui[222])
    sampSendChat(mstag_target)
    return false
  elseif command:match("/.*(<city>).*") then
    local mstag_city = command:gsub("<city>", table_imgui[229])
    sampSendChat(mstag_city)
    return false
  elseif command:match("/.*(<marking_number>).*") then
    local mstag_marking = command:gsub("<marking_number>", table_imgui[2] .. "-" .. table_imgui[3])
    sampSendChat(mstag_marking)
    return false
  elseif command:match("/.*(<to>).*") then
    local mstag_to = command:gsub("<to>", table_imgui[4])
    sampSendChat(mstag_to)
    return false
  elseif command:match("/.*(<myid>).*") then
    local mstag_to = command:gsub("<myid>", ind)
    sampSendChat(mstag_to)
    return false
  end
end

function RpCommand(arg)
  if arg == 1 then
    if mainCommand[25].enabled then
      wait(2500)
      sampSendChat("/me изъяв все найденное, помещает его в пакетики.")
      wait(2500)
      sampSendChat("/me вытянув из бардачка сумку с надписью \"Улики\", открывает ее.")
      wait(2500)
      sampSendChat("/me осторожно складывает все вещи в нее и, закрыв, ложит себе на колени.")
      wait(2500)
      sampSendChat("/me снимает перчатки и выбрасывает.")
    end
  elseif arg == 2 then
    if mainCommand[26].enabled then
      wait(2500)
      sampSendChat("/me снимает с пояса пару резиновых перчаток и натягивает на руки.")
      wait(2500)
      sampSendChat("/me начинает обыскивать человека и ложить на землю все найденные вещи.")
    end
  elseif arg == 3 then
    if mainCommand[30].enabled then
      wait(2500)
      sampSendChat("/me резко извлекает дубинку с поясного держателя.")
      setCurrentCharWeapon(PLAYER_PED, 3)
      wait(2500)
      sampSendChat("/me выбив стекло головкой дубинки, быстро фиксирует ее на поясе.")
      wait(2500)
      sampSendChat("/me выволачивает водителя из транспорта и, уложив на землю, заламывает руки за спину.")
    end
  elseif arg == 4 then
    if mainCommand[31].enabled then
      wait(2500)
      setCurrentCharWeapon(PLAYER_PED, 0)
      sampSendChat("/me открывает дверь и, придерживая голову, осторожно садит задержанного в машину.")
    end 
  elseif arg == 5 then
    if mainCommand[33].enabled then
      wait(2500)
      sampSendChat("/me докладывает диспетчеру о привезенном преступнике.")
      wait(2500)
      sampSendChat("/do [Диспетчер]: Ожидайте у запасного выхода, направляю людей...")
      wait(2500)
      sampSendChat("/do Через пару тройку секунд из департамента выходят полицейские и забирают преступника и его вещи.")
    end   
  elseif arg == 6 then
    if mainCommand[34].enabled then
      wait(2500)
      setCurrentCharWeapon(PLAYER_PED, 0)
      sampSendChat("/me ухватив задержанного за плече и левую руку, начинает вести за собой.")
    end  
  elseif arg == 7 then
    if mainCommand[35].enabled then
      wait(2500)
      sampSendChat("/me убирает руки из плеча и руки задержанного.")
    end  
  elseif arg == 8 then
    if mainCommand[27].enabled then
      wait(2500)
      setCurrentCharWeapon(PLAYER_PED, 0)
      sampSendChat("/me сняв наручники с пояса, надевает их на руки задержанного.")
    end
  elseif arg == 9 then
    if mainCommand[28].enabled then
      wait(2500)
      setCurrentCharWeapon(PLAYER_PED, 0)
      sampSendChat("/me сняв с пояса ключ, снимает наручники и вешает их на пояс с ключем.")
    end 
  elseif arg == 10 then
    if mainCommand[23].enabled then
      wait(2500)
      sampSendChat("/me связавшись с диспетчером, диктует ему даные для изменения уровня розыска.")
    end
  elseif arg == 11 then
    if table_imgui[212].v or not table_imgui[245].v then
      if mainCommand[22].enabled then
        wait(2500)
        sampSendChat("/me связавшись с диспетчером, диктует ему данные для обьявления в розыск и номер жетона.")
      end
    end
  elseif arg == 12 then
    if table_imgui[212].v or not table_imgui[245].v then
      if mainCommand[32].enabled then
        wait(2500)
        sampSendChat("/me достав ручку и бланк из нагрудного кармана, выписывает штраф водителю.")
      end
    end
  elseif arg == 13 then
    if mainCommand[29].enabled then
      wait(2500)
      sampSendChat("/me срывает маску с задержанного и бросает на землю.")
    end
  elseif arg == 14 then
    sampSendChat("Здраствуйте, попрошу предъявить свои документы.")
    sampSendChat("/showbadge " .. arg_su)
  elseif arg == 15 then
    if mainCommand[1].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана дисплей спутникового мониторинга.")
      wait(2500)
      sampSendChat("/me введя данные, начинает отслеживать перемещение цели.")
    end
  elseif arg == 16 then
    if mainCommand[2].enabled then
      wait(2500)
      sampSendChat("/me снимает с защелки на ремне маску, расправляет и натягивает на голову.")
    end
  elseif arg == 17 then
    if mainCommand[3].enabled then
      wait(2500)
      sampSendChat("/me незаметно надавливает пяткой на каблук левого ботинка.")
    end
  elseif arg == 18 then
    if mainCommand[4].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me легким движением пальца открывает Базу Федерального Розыска.")
    end
  elseif arg == 19 then
    if mainCommand[5].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me легким движением пальца открывает Базу Сотрудников Штата.")
      wait(2500)
      sampSendChat("/me найдя нужное имя, обновляет информацию и прячет КПК.")
    end
  elseif arg == 20 then
    if mainCommand[6].enabled then
      wait(2500)
      sampSendChat("/me схватив скрепки, бросает их на землю.")
    end
  elseif arg == 21 then
    if mainCommand[7].enabled then
      wait(2500)
      sampSendChat("/me хватает мешок и резко срывает с головы.")
    end
  elseif arg == 22 then
    if mainCommand[8].enabled then
      wait(2500)
      sampSendChat("/me медленно развязывает петлю из запястий задержанного.")
    end
  elseif arg == 23 then
    if mainCommand[9].enabled then
      wait(2500)
      sampSendChat("/me ухватив голову, осторожно вытаскивает кляп изо рта.")
    end
  elseif arg == 24 then
    if mainCommand[10].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и устанавливает метку на карте.")
    end
  elseif arg == 25 then
    if mainCommand[11].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и вносит данные о новом сотруднике.")
    end
  elseif arg == 26 then
    if mainCommand[12].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и стирает данные о сотруднике.")
    end
  elseif arg == 27 then
    if mainCommand[13].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и вносит изменения в данные сотрудника.")
    end
  elseif arg == 28 then
    if mainCommand[14].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и вносит выговор в данные сотрудника.")
    end
  elseif arg == 29 then
    if mainCommand[15].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и вносит выговор в данные сотрудника.")
    end
  elseif arg == 30 then
    if mainCommand[16].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и удаляет выговор из данных сотрудника.")
    end
  elseif arg == 31 then
    if mainCommand[17].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и удаляет выговор из данных сотрудника.")
    end
  elseif arg == 32 then
    if mainCommand[18].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и изменяет сотруднику права доступа к радиоканалу.")
    end
  elseif arg == 33 then
    if mainCommand[19].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и изменяет сотруднику права доступа к радиоканалу.")
    end
  elseif arg == 34 then
    if mainCommand[20].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел управления составом и изменяет сотруднику права доступа к радиоканалу.")
    end
  elseif arg == 35 then
    if mainCommand[21].enabled then
      wait(2500)
      sampSendChat("/me достает из нагрудного кармана КПК и включает его.")
      wait(2500)
      sampSendChat("/me переходит в раздел финансов " .. u8:decode(mainSetting.setting[9]) .. " и вносит данные o выделении премий.")
      wait(2500)
      sampSendChat("/me нажимает на кнопку \"Отправить\".")
    end
  elseif arg == 36 then
    if mainCommand[24].enabled then
      wait(2500)
      sampSendChat("/me связавшись с диспетчером, диктует ему даные для изменения уровня розыска.")
    end
  elseif arg == 37 then
    if mainCommand[36].enabled then
      wait(2500)
      sampSendChat("/me вздернув лямку, достает из нагрудного кармана удостоверение.")
      wait(2500)
      sampSendChat("/me в одной руке держит удостоверение, другой указывает на значок, закрепленный в области груди.")
      wait(4000)
      sampSendChat("/me прячет удостоверение обратно в карман.")
    end
  end
end

function func_su_umn()
	table_imgui[5] = "0"
	table_imgui[26].v = not table_imgui[26].v
  sampSendChat("/su " .. table.concat(table_imgui, " ", 115, 117) .. " ЕФК")
  table_imgui[115] = ""
	table_imgui[116] = ""
	table_imgui[117] = ""
  if table_imgui[212].v then
    wait(2500)
    sampSendChat("/me связавшись с диспетчером, диктует ему даные для обьявления в розыск и свой жетон.")
    if table_imgui[213].v then
      wait(500)
      sampSendChat("/time")
    end
    if table_imgui[214].v then
      setVirtualKeyDown(vkey.VK_F8, true)
		  wait(600)
		  setVirtualKeyDown(vkey.VK_F8, false)
    end
  end
end

function su_zapros(id, level, article)
  if id and level and article then
    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] - [DISP]: Диспетчер, объявите в розыск дело № " .. id .. ", " .. level .. " уровень розыска.")
    wait(2500)
    sampSendChat("/r [" .. table.concat(table_imgui, ".", 93, 94) .. "] - [DISP]: Причина: " .. article .. " ЕФК.")
  else
    sampAddChatMessage("{696969} >| {1adb6e}Что-то пошло не так, доклад невозможен.", -1)
  end  
end

function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\config\\YAversion.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
