" Vim syntax file
" Language:     Markdown
" Maintainer:   Gabriele Lana <gabriele.lana@gmail.com>
" Filenames:    *.md

if exists("b:current_syntax")
  finish
endif

syn spell toplevel
syn sync minlines=342
syn case ignore

syn region markdownH1 matchgroup=markdownHeadingDelimiter start="^#"      end="#*\s*$" oneline contains=@markdownInline
syn region markdownH2 matchgroup=markdownHeadingDelimiter start="^##"     end="#*\s*$" oneline contains=@markdownInline
syn region markdownH3 matchgroup=markdownHeadingDelimiter start="^###"    end="#*\s*$" oneline contains=@markdownInline
syn region markdownH4 matchgroup=markdownHeadingDelimiter start="^####"   end="#*\s*$" oneline contains=@markdownInline
syn region markdownH5 matchgroup=markdownHeadingDelimiter start="^#####"  end="#*\s*$" oneline contains=@markdownInline
syn region markdownH6 matchgroup=markdownHeadingDelimiter start="^######" end="#*\s*$" oneline contains=@markdownInline

syn match markdownHeadingUnderline "^[=-]\+$" contained
syn match markdownH1 "^.\+\n=\+$" contains=@markdownInline,markdownHeadingUnderline
syn match markdownH2 "^.\+\n-\+$" contains=@markdownInline,markdownHeadingUnderline

syn match markdownListDelimiter "^\s*\%([-*+]\|\d\.\)\s\+" contained
syn region markdownListItem transparent keepend contains=markdownListDelimiter,markdownListItem,@markdownInline
  \ start="^\z(\s*\)\%([-*+]\|\d\.\)\s\+"
  \ end="\n\%(^\z1\%([-*+]\|\d\.\)\s\+\|\n\S\)\@="

syn match markdownRule "^\s*\*\s*\*\s*\*[[:space:]*]*$"
syn match markdownRule "^\s*-\s*-\s*-[[:space:]-]*$"
syn match markdownRule "^\s*_\s*_\s*_[[:space:]_]*$"

syn match markdownBlockquoteDelimiter "^\%(\s\|>\)\+" contained
syn match markdownBlockquote "^\s*>\%(.\+\n\)\+\n*" contains=markdownBlockquoteDelimiter

syn region markdownCode matchgroup=markdownCodeDelimiter start="`" end="`" keepend contains=@NoSpell
syn region markdownCode matchgroup=markdownCodeDelimiter start="`` \=" end=" \=``" keepend contains=@NoSpell
syn region markdownCode matchgroup=markdownCodeDelimiter start="^\s*```.*$" end="^\s*```\ze\s*$" contains=@NoSpell

syn match markdownStrikeDelimiter "\~\~" contained
syn match markdownStrike "\%(\\\)\@<!\~\~\%(\S\)\@=\%(.\|\n\)\{-}\%(\S\)\@<=\~\~" contains=markdownStrikeDelimiter,@markdownInline

syn region markdownItalic matchgroup=markdownInlineDelimiter contains=markdownItalic
  \ start="\%(\s\|_\|^\)\@<=\*\%(\s\|\*\|$\)\@!" end="\%(\s\|\*\)\@<!\*"
syn region markdownItalic matchgroup=markdownInlineDelimiter contains=markdownItalic
  \ start="\%(\s\|\*\|^\)\@<=_\%(\s\|_\|$\)\@!" end="\%(\s\|_\)\@<!_"
syn region markdownBold matchgroup=markdownInlineDelimiter contains=markdownBold
  \ start="\%(\s\|__\|^\)\@<=\*\*\%(\s\|\*\|$\)\@!" end="\%(\s\|\*\*\)\@<!\*\*"
syn region markdownBold matchgroup=markdownInlineDelimiter contains=markdownBold
  \ start="\%(\s\|\*\*\|^\)\@<=__\%(\s\|_\|$\)\@!" end="\%(\s\|__\)\@<!__"

syn region markdownBoldItalic matchgroup=markdownInlineDelimiter
  \ start="\%(\s\|_\|^\)\@<=\*\*\*\%(\s\|\*\|$\)\@!" end="\%(\s\|\*\)\@<!\*\*\*"
syn region markdownBoldItalic matchgroup=markdownInlineDelimiter
  \ start="\%(\s\|\*\|^\)\@<=___\%(\s\|_\|$\)\@!" end="\%(\s\|_\)\@<!___"
syn region markdownBoldItalic matchgroup=markdownInlineDelimiter
  \ start="\%(\s\|_\|^\)\@<=\*\*_\%(\s\|_\|$\)\@!" end="\%(\s\|_\)\@<!_\*\*"
syn region markdownBoldItalic matchgroup=markdownInlineDelimiter
  \ start="\%(\s\|\*\|^\)\@<=__\*\%(\s\|\*\|$\)\@!" end="\%(\s\|\*\)\@<!\*__"

syn match markdownPullRequestLinkInText /\%(\w\)\@<!#\d\+/
syn match markdownUserLinkInText /\%(\w\)\@<!@[[:alnum:]._\/-]\+/ contains=@NoSpell
syn match markdownEmailLinkInText /[[:alnum:]._%+-]\+@[[:alnum:].-]\+\.\w\{2,4}/ contains=@NoSpell


" /\c\<                                           # case insensitive, beginning of a word
" \%(\%(https\?\|ftp\|file\):\/\/\|www\.\|ftp\.\) # the schema is optional
" \%((C*)\|\[C*\]\|{C*}\|C\)*                     # pair of parenthesis that surround a piece
"                                                 # of an url or a piece of url, all optional
" \%((C*)\|\[C*\]\|{C*}\|T*\)*                    # same as above but the terminal part of an
"                                                 # url could not be punctuation
let b:markdown_syntax_url =
  \ '\c'
  \ . '<\?'
  \ . '\%('
  \ .   '\%(\<\%(https\?\|ftp\|file\):\/\/\|www\.\|ftp\.\)'
  \ .   '\|'
  \ .   '\/\%([^/]\)\@='
  \ . '\)'
  \ . '\%('
  \ .   '&#\?[0-9A-Za-z]\{1,8};'
  \ .   '\|'
  \ .   '\\'
  \ .   '\|'
  \ .   '([-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?)'
  \ .   '\|'
  \ .   '\[[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?\]'
  \ .   '\|'
  \ .   '{[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?}'
  \ .   '\|'
  \ .   '[-A-Z0-9+&@#/%=~_|$?!:,.]'
  \ . '\)*'
  \ . '\%('
  \ .   '&#\?[0-9A-Za-z]\{1,8};'
  \ .   '\|'
  \ .   '\\'
  \ .   '\|'
  \ .   '([-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?)'
  \ .   '\|'
  \ .   '\[[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?\]'
  \ .   '\|'
  \ .   '{[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?}'
  \ .   '\|'
  \ .   '[-A-Z0-9+&@#/%=~_|$]\+'
  \ . '\)'
  \ . '>\?'

execute 'syn match markdownUrlLinkInText /' . b:markdown_syntax_url . '/ contains=@NoSpell'


" something encosed in square brackets
" could not be preceded by a backslash
" could contain pairs of square brackets
" could contain pairs of escaped square brackets
" could contain no more than two consecutive newlines
" could contain single square brackets escaped
" could not contain unbalanced square brackets like 'a [ b \] c'
" could not contain nested square brackets
let b:markdown_syntax_square_brackets_block =
  \ '\%(\\\)\@<!\['
  \ . '\%('
  \ .   '\[.\{-\}\]'
  \ .   '\|'
  \ .   '\\\[.\{-\}\\\]'
  \ .   '\|'
  \ .   '\n\%(\n\)\@!'
  \ .   '\|[^\[\]]*'
  \ .   '\|'
  \ .   '\\\['
  \ .   '\|'
  \ .   '\\\]'
  \ . '\)\+'
  \ . '\]'

" something encosed in round brackets
" could not be preceded by a backslash
" could contain pairs of round brackets
" could contain pairs of escaped round brackets
" could contain no more than two consecutive newlines
" could contain single round brackets escaped
" could not contain unbalanced round brackets like 'a [ b \] c'
" could not contain nested round brackets
let b:markdown_syntax_round_brackets_block =
  \ '\%(\\\)\@<!('
  \ . '\%('
  \ .   '(.\{-\})'
  \ .   '\|'
  \ .   '\\(.\{-\}\\)'
  \ .   '\|'
  \ .   '\n\%(\n\)\@!'
  \ .   '\|'
  \ .   '[^()]*'
  \ .   '\|'
  \ .   '\\('
  \ .   '\|'
  \ .   '\\)'
  \ . '\)\+'
  \ . ')'

execute 'syn match markdownLinkContainer '
  \ . 'contains=markdownLinkTextContainer,markdownLinkUrlContainer transparent '
  \ . '/'
  \ . b:markdown_syntax_square_brackets_block
  \ . '\%(\s*\|\n\%\(\n\)\@!\)'
  \ . '\%('
  \ .   b:markdown_syntax_round_brackets_block
  \ .   '\|'
  \ .   b:markdown_syntax_square_brackets_block
  \ . '\)'
  \ . '/'

execute 'syn match markdownLinkTextContainer contained '
  \ . 'contains=markdownLinkText '
  \ . '/'
  \ . b:markdown_syntax_square_brackets_block
  \ . '/'

execute 'syn match markdownLinkText contained '
  \ . 'contains=@markdownInline '
  \ . '/'
  \ . b:markdown_syntax_square_brackets_block
  \ . '/'
  \ . 'hs=s+1,he=e-1'

execute 'syn match markdownLinkUrlContainer contained '
  \ . 'contains=markdownLinkUrl,markdownLinkTitleSingleQuoted,markdownLinkTitleDoubleQuoted '
  \ . '/'
  \ . b:markdown_syntax_round_brackets_block
  \ . '/'

execute 'syn match markdownLinkUrl contained '
  \ . 'contains=@NoSpell '
  \ . '/'
  \ . '\%((\)\@<='
  \ . '\%('
  \ .   '&#\?[0-9A-Za-z]\{1,8};'
  \ .   '\|'
  \ .   '\\'
  \ .   '\|'
  \ .   '([-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?)'
  \ .   '\|'
  \ .   '\[[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?\]'
  \ .   '\|'
  \ .   '{[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?}'
  \ .   '\|'
  \ .   '[-A-Z0-9+&@#/%=~_|$?!:,.]'
  \ .   '\|'
  \ .   '\s'
  \ . '\)\+'
  \ . '\%(\s\+["'']\|)\|\n\)\@='
  \ . '/'

syn region markdownLinkTitleSingleQuoted start=/\s*'/ skip=/\\'/ end=/'\_s*/
  \ keepend contained contains=@markdownInline

syn region markdownLinkTitleDoubleQuoted start=/\s*"/ skip=/\\"/ end=/"\_s*/
  \ keepend contained contains=@markdownInline

execute 'syn match markdownLinkReference '
  \ . 'contains=markdownLinkTitleSingleQuoted,markdownLinkTitleDoubleQuoted,@markdownInline '
  \ . '/'
  \ . '^\s\{,3}'
  \ . b:markdown_syntax_square_brackets_block
  \ . '\%('
  \ .   ':.*'
  \ .   '\%(\n\%\(\n\)\@!.*$\)\?'
  \ . '\)\?'
  \ . '/'









syn match markdownXmlComment /\c<\!--\_.\{-}-->/ contains=@NoSpell
syn match markdownXmlElement /\c<\([-A-Z0-9_$?!:,.]\+\)[^>]\{-}>\_.\{-}<\/\1>/ contains=@NoSpell
syn match markdownXmlEmptyElement /\c<\([-A-Z0-9_$?!:,.]\+\)\%(\s+[^>]\{-}\/>\|\/>\)/ contains=@NoSpell
syn match markdownXmlEntities /&#\?[0-9A-Za-z]\{1,8};/ contains=@NoSpell

syn cluster markdownInline contains=
  \ markdownItalic,markdownBold,markdownBoldItalic,
  \ markdownStrike,markdownCode,markdownPullRequestLinkInText,
  \ markdownUrlLinkInText,markdownUserLinkInText,markdownEmailLinkInText,
  \ markdownEmoticonsKeyword,markdownLinkContainer,markdownXmlComment,
  \ markdownXmlElement,markdownXmlEmptyElement,markdownXmlEntities

syn keyword markdownEmoticonKeyword :bowtie: :smile: :laughing: :blush: :smiley:
syn keyword markdownEmoticonKeyword :bowtie: :smile: :laughing: :blush: :smiley:
syn keyword markdownEmoticonKeyword :relaxed: :smirk: :heart_eyes: :kissing_heart: :kissing_closed_eyes:
syn keyword markdownEmoticonKeyword :flushed: :relieved: :satisfied: :grin: :wink:
syn keyword markdownEmoticonKeyword :stuck_out_tongue_winking_eye: :stuck_out_tongue_closed_eyes: :grinning: :kissing: :kissing_smiling_eyes:
syn keyword markdownEmoticonKeyword :stuck_out_tongue: :sleeping: :worried: :frowning: :anguished:
syn keyword markdownEmoticonKeyword :open_mouth: :grimacing: :confused: :hushed: :expressionless:
syn keyword markdownEmoticonKeyword :unamused: :sweat_smile: :sweat: :disappointed_relieved: :weary:
syn keyword markdownEmoticonKeyword :pensive: :disappointed: :confounded: :fearful: :cold_sweat:
syn keyword markdownEmoticonKeyword :persevere: :cry: :sob: :joy: :astonished:
syn keyword markdownEmoticonKeyword :scream: :neckbeard: :tired_face: :angry: :rage:
syn keyword markdownEmoticonKeyword :triumph: :sleepy: :yum: :mask: :sunglasses:
syn keyword markdownEmoticonKeyword :dizzy_face: :imp: :smiling_imp: :neutral_face: :no_mouth:
syn keyword markdownEmoticonKeyword :innocent: :alien: :yellow_heart: :blue_heart: :purple_heart:
syn keyword markdownEmoticonKeyword :heart: :green_heart: :broken_heart: :heartbeat: :heartpulse:
syn keyword markdownEmoticonKeyword :two_hearts: :revolving_hearts: :cupid: :sparkling_heart: :sparkles:
syn keyword markdownEmoticonKeyword :star: :star2: :dizzy: :boom: :collision:
syn keyword markdownEmoticonKeyword :anger: :exclamation: :question: :grey_exclamation: :grey_question:
syn keyword markdownEmoticonKeyword :zzz: :dash: :sweat_drops: :notes: :musical_note:
syn keyword markdownEmoticonKeyword :fire: :hankey: :poop: :shit: :+1:
syn keyword markdownEmoticonKeyword :thumbsup: :-1: :thumbsdown: :ok_hand: :punch:
syn keyword markdownEmoticonKeyword :facepunch: :fist: :v: :wave: :hand:
syn keyword markdownEmoticonKeyword :raised_hand: :open_hands: :point_up: :point_down: :point_left:
syn keyword markdownEmoticonKeyword :point_right: :raised_hands: :pray: :point_up_2: :clap:
syn keyword markdownEmoticonKeyword :muscle: :metal: :fu: :walking: :runner:
syn keyword markdownEmoticonKeyword :running: :couple: :family: :two_men_holding_hands: :two_women_holding_hands:
syn keyword markdownEmoticonKeyword :dancer: :dancers: :ok_woman: :no_good: :information_desk_person:
syn keyword markdownEmoticonKeyword :raising_hand: :bride_with_veil: :person_with_pouting_face: :person_frowning: :bow:
syn keyword markdownEmoticonKeyword :couplekiss: :couple_with_heart: :massage: :haircut: :nail_care:
syn keyword markdownEmoticonKeyword :boy: :girl: :woman: :man: :baby:
syn keyword markdownEmoticonKeyword :older_woman: :older_man: :person_with_blond_hair: :man_with_gua_pi_mao: :man_with_turban:
syn keyword markdownEmoticonKeyword :construction_worker: :cop: :angel: :princess: :smiley_cat:
syn keyword markdownEmoticonKeyword :smile_cat: :heart_eyes_cat: :kissing_cat: :smirk_cat: :scream_cat:
syn keyword markdownEmoticonKeyword :crying_cat_face: :joy_cat: :pouting_cat: :japanese_ogre: :japanese_goblin:
syn keyword markdownEmoticonKeyword :see_no_evil: :hear_no_evil: :speak_no_evil: :guardsman: :skull:
syn keyword markdownEmoticonKeyword :feet: :lips: :kiss: :droplet: :ear:
syn keyword markdownEmoticonKeyword :eyes: :nose: :tongue: :love_letter: :bust_in_silhouette:
syn keyword markdownEmoticonKeyword :busts_in_silhouette: :speech_balloon: :thought_balloon: :feelsgood: :finnadie:
syn keyword markdownEmoticonKeyword :goberserk: :godmode: :hurtrealbad: :rage1: :rage2:
syn keyword markdownEmoticonKeyword :rage3: :rage4: :suspect: :trollface: :sunny:
syn keyword markdownEmoticonKeyword :umbrella: :cloud: :snowflake: :snowman: :zap:
syn keyword markdownEmoticonKeyword :cyclone: :foggy: :ocean: :cat: :dog:
syn keyword markdownEmoticonKeyword :mouse: :hamster: :rabbit: :wolf: :frog:
syn keyword markdownEmoticonKeyword :tiger: :koala: :bear: :pig: :pig_nose:
syn keyword markdownEmoticonKeyword :cow: :boar: :monkey_face: :monkey: :horse:
syn keyword markdownEmoticonKeyword :racehorse: :camel: :sheep: :elephant: :panda_face:
syn keyword markdownEmoticonKeyword :snake: :bird: :baby_chick: :hatched_chick: :hatching_chick:
syn keyword markdownEmoticonKeyword :chicken: :penguin: :turtle: :bug: :honeybee:
syn keyword markdownEmoticonKeyword :ant: :beetle: :snail: :octopus: :tropical_fish:
syn keyword markdownEmoticonKeyword :fish: :whale: :whale2: :dolphin: :cow2:
syn keyword markdownEmoticonKeyword :ram: :rat: :water_buffalo: :tiger2: :rabbit2:
syn keyword markdownEmoticonKeyword :dragon: :goat: :rooster: :dog2: :pig2:
syn keyword markdownEmoticonKeyword :mouse2: :ox: :dragon_face: :blowfish: :crocodile:
syn keyword markdownEmoticonKeyword :dromedary_camel: :leopard: :cat2: :poodle: :paw_prints:
syn keyword markdownEmoticonKeyword :bouquet: :cherry_blossom: :tulip: :four_leaf_clover: :rose:
syn keyword markdownEmoticonKeyword :sunflower: :hibiscus: :maple_leaf: :leaves: :fallen_leaf:
syn keyword markdownEmoticonKeyword :herb: :mushroom: :cactus: :palm_tree: :evergreen_tree:
syn keyword markdownEmoticonKeyword :deciduous_tree: :chestnut: :seedling: :blossom: :ear_of_rice:
syn keyword markdownEmoticonKeyword :shell: :globe_with_meridians: :sun_with_face: :full_moon_with_face: :new_moon_with_face:
syn keyword markdownEmoticonKeyword :new_moon: :waxing_crescent_moon: :first_quarter_moon: :waxing_gibbous_moon: :full_moon:
syn keyword markdownEmoticonKeyword :waning_gibbous_moon: :last_quarter_moon: :waning_crescent_moon: :last_quarter_moon_with_face: :first_quarter_moon_with_face:
syn keyword markdownEmoticonKeyword :moon: :earth_africa: :earth_americas: :earth_asia: :volcano:
syn keyword markdownEmoticonKeyword :milky_way: :partly_sunny: :octocat: :squirrel: :bamboo:
syn keyword markdownEmoticonKeyword :gift_heart: :dolls: :school_satchel: :mortar_board: :flags:
syn keyword markdownEmoticonKeyword :fireworks: :sparkler: :wind_chime: :rice_scene: :jack_o_lantern:
syn keyword markdownEmoticonKeyword :ghost: :santa: :christmas_tree: :gift: :bell:
syn keyword markdownEmoticonKeyword :no_bell: :tanabata_tree: :tada: :confetti_ball: :balloon:
syn keyword markdownEmoticonKeyword :crystal_ball: :cd: :dvd: :floppy_disk: :camera:
syn keyword markdownEmoticonKeyword :video_camera: :movie_camera: :computer: :tv: :iphone:
syn keyword markdownEmoticonKeyword :phone: :telephone: :telephone_receiver: :pager: :fax:
syn keyword markdownEmoticonKeyword :minidisc: :vhs: :sound: :speaker: :mute:
syn keyword markdownEmoticonKeyword :loudspeaker: :mega: :hourglass: :hourglass_flowing_sand: :alarm_clock:
syn keyword markdownEmoticonKeyword :watch: :radio: :satellite: :loop: :mag:
syn keyword markdownEmoticonKeyword :mag_right: :unlock: :lock: :lock_with_ink_pen: :closed_lock_with_key:
syn keyword markdownEmoticonKeyword :key: :bulb: :flashlight: :high_brightness: :low_brightness:
syn keyword markdownEmoticonKeyword :electric_plug: :battery: :calling: :email: :mailbox:
syn keyword markdownEmoticonKeyword :postbox: :bath: :bathtub: :shower: :toilet:
syn keyword markdownEmoticonKeyword :wrench: :nut_and_bolt: :hammer: :seat: :moneybag:
syn keyword markdownEmoticonKeyword :yen: :dollar: :pound: :euro: :credit_card:
syn keyword markdownEmoticonKeyword :money_with_wings: :e-mail: :inbox_tray: :outbox_tray: :envelope:
syn keyword markdownEmoticonKeyword :incoming_envelope: :postal_horn: :mailbox_closed: :mailbox_with_mail: :mailbox_with_no_mail:
syn keyword markdownEmoticonKeyword :door: :smoking: :bomb: :gun: :hocho:
syn keyword markdownEmoticonKeyword :pill: :syringe: :page_facing_up: :page_with_curl: :bookmark_tabs:
syn keyword markdownEmoticonKeyword :bar_chart: :chart_with_upwards_trend: :chart_with_downwards_trend: :scroll: :clipboard:
syn keyword markdownEmoticonKeyword :calendar: :date: :card_index: :file_folder: :open_file_folder:
syn keyword markdownEmoticonKeyword :scissors: :pushpin: :paperclip: :black_nib: :pencil2:
syn keyword markdownEmoticonKeyword :straight_ruler: :triangular_ruler: :closed_book: :green_book: :blue_book:
syn keyword markdownEmoticonKeyword :orange_book: :notebook: :notebook_with_decorative_cover: :ledger: :books:
syn keyword markdownEmoticonKeyword :bookmark: :name_badge: :microscope: :telescope: :newspaper:
syn keyword markdownEmoticonKeyword :football: :basketball: :soccer: :baseball: :tennis:
syn keyword markdownEmoticonKeyword :8ball: :rugby_football: :bowling: :golf: :mountain_bicyclist:
syn keyword markdownEmoticonKeyword :bicyclist: :horse_racing: :snowboarder: :swimmer: :surfer:
syn keyword markdownEmoticonKeyword :ski: :spades: :hearts: :clubs: :diamonds:
syn keyword markdownEmoticonKeyword :gem: :ring: :trophy: :musical_score: :musical_keyboard:
syn keyword markdownEmoticonKeyword :violin: :space_invader: :video_game: :black_joker: :flower_playing_cards:
syn keyword markdownEmoticonKeyword :game_die: :dart: :mahjong: :clapper: :memo:
syn keyword markdownEmoticonKeyword :pencil: :book: :art: :microphone: :headphones:
syn keyword markdownEmoticonKeyword :trumpet: :saxophone: :guitar: :shoe: :sandal:
syn keyword markdownEmoticonKeyword :high_heel: :lipstick: :boot: :shirt: :tshirt:
syn keyword markdownEmoticonKeyword :necktie: :womans_clothes: :dress: :running_shirt_with_sash: :jeans:
syn keyword markdownEmoticonKeyword :kimono: :bikini: :ribbon: :tophat: :crown:
syn keyword markdownEmoticonKeyword :womans_hat: :mans_shoe: :closed_umbrella: :briefcase: :handbag:
syn keyword markdownEmoticonKeyword :pouch: :purse: :eyeglasses: :fishing_pole_and_fish: :coffee:
syn keyword markdownEmoticonKeyword :tea: :sake: :baby_bottle: :beer: :beers:
syn keyword markdownEmoticonKeyword :cocktail: :tropical_drink: :wine_glass: :fork_and_knife: :pizza:
syn keyword markdownEmoticonKeyword :hamburger: :fries: :poultry_leg: :meat_on_bone: :spaghetti:
syn keyword markdownEmoticonKeyword :curry: :fried_shrimp: :bento: :sushi: :fish_cake:
syn keyword markdownEmoticonKeyword :rice_ball: :rice_cracker: :rice: :ramen: :stew:
syn keyword markdownEmoticonKeyword :oden: :dango: :egg: :bread: :doughnut:
syn keyword markdownEmoticonKeyword :custard: :icecream: :ice_cream: :shaved_ice: :birthday:
syn keyword markdownEmoticonKeyword :cake: :cookie: :chocolate_bar: :candy: :lollipop:
syn keyword markdownEmoticonKeyword :honey_pot: :apple: :green_apple: :tangerine: :lemon:
syn keyword markdownEmoticonKeyword :cherries: :grapes: :watermelon: :strawberry: :peach:
syn keyword markdownEmoticonKeyword :melon: :banana: :pear: :pineapple: :sweet_potato:
syn keyword markdownEmoticonKeyword :eggplant: :tomato: :corn: :house: :house_with_garden:
syn keyword markdownEmoticonKeyword :school: :office: :post_office: :hospital: :bank:
syn keyword markdownEmoticonKeyword :convenience_store: :love_hotel: :hotel: :wedding: :church:
syn keyword markdownEmoticonKeyword :department_store: :european_post_office: :city_sunrise: :city_sunset: :japanese_castle:
syn keyword markdownEmoticonKeyword :european_castle: :tent: :factory: :tokyo_tower: :japan:
syn keyword markdownEmoticonKeyword :mount_fuji: :sunrise_over_mountains: :sunrise: :stars: :statue_of_liberty:
syn keyword markdownEmoticonKeyword :bridge_at_night: :carousel_horse: :rainbow: :ferris_wheel: :fountain:
syn keyword markdownEmoticonKeyword :roller_coaster: :ship: :speedboat: :boat: :sailboat:
syn keyword markdownEmoticonKeyword :rowboat: :anchor: :rocket: :airplane: :helicopter:
syn keyword markdownEmoticonKeyword :steam_locomotive: :tram: :mountain_railway: :bike: :aerial_tramway:
syn keyword markdownEmoticonKeyword :suspension_railway: :mountain_cableway: :tractor: :blue_car: :oncoming_automobile:
syn keyword markdownEmoticonKeyword :car: :red_car: :taxi: :oncoming_taxi: :articulated_lorry:
syn keyword markdownEmoticonKeyword :bus: :oncoming_bus: :rotating_light: :police_car: :oncoming_police_car:
syn keyword markdownEmoticonKeyword :fire_engine: :ambulance: :minibus: :truck: :train:
syn keyword markdownEmoticonKeyword :station: :train2: :bullettrain_front: :bullettrain_side: :light_rail:
syn keyword markdownEmoticonKeyword :monorail: :railway_car: :trolleybus: :ticket: :fuelpump:
syn keyword markdownEmoticonKeyword :vertical_traffic_light: :traffic_light: :warning: :construction: :beginner:
syn keyword markdownEmoticonKeyword :atm: :slot_machine: :busstop: :barber: :hotsprings:
syn keyword markdownEmoticonKeyword :checkered_flag: :crossed_flags: :izakaya_lantern: :moyai: :circus_tent:
syn keyword markdownEmoticonKeyword :performing_arts: :round_pushpin: :triangular_flag_on_post: :jp: :kr:
syn keyword markdownEmoticonKeyword :cn: :us: :fr: :es: :it:
syn keyword markdownEmoticonKeyword :ru: :gb: :uk: :de: :one:
syn keyword markdownEmoticonKeyword :two: :three: :four: :five: :six:
syn keyword markdownEmoticonKeyword :seven: :eight: :nine: :keycap_ten: :1234:
syn keyword markdownEmoticonKeyword :zero: :hash: :symbols: :arrow_backward: :arrow_down:
syn keyword markdownEmoticonKeyword :arrow_forward: :arrow_left: :capital_abcd: :abcd: :abc:
syn keyword markdownEmoticonKeyword :arrow_lower_left: :arrow_lower_right: :arrow_right: :arrow_up: :arrow_upper_left:
syn keyword markdownEmoticonKeyword :arrow_upper_right: :arrow_double_down: :arrow_double_up: :arrow_down_small: :arrow_heading_down:
syn keyword markdownEmoticonKeyword :arrow_heading_up: :leftwards_arrow_with_hook: :arrow_right_hook: :left_right_arrow: :arrow_up_down:
syn keyword markdownEmoticonKeyword :arrow_up_small: :arrows_clockwise: :arrows_counterclockwise: :rewind: :fast_forward:
syn keyword markdownEmoticonKeyword :information_source: :ok: :twisted_rightwards_arrows: :repeat: :repeat_one:
syn keyword markdownEmoticonKeyword :new: :top: :up: :cool: :free:
syn keyword markdownEmoticonKeyword :ng: :cinema: :koko: :signal_strength: :u5272:
syn keyword markdownEmoticonKeyword :u5408: :u55b6: :u6307: :u6708: :u6709:
syn keyword markdownEmoticonKeyword :u6e80: :u7121: :u7533: :u7a7a: :u7981:
syn keyword markdownEmoticonKeyword :sa: :restroom: :mens: :womens: :baby_symbol:
syn keyword markdownEmoticonKeyword :no_smoking: :parking: :wheelchair: :metro: :baggage_claim:
syn keyword markdownEmoticonKeyword :accept: :wc: :potable_water: :put_litter_in_its_place: :secret:
syn keyword markdownEmoticonKeyword :congratulations: :m: :passport_control: :left_luggage: :customs:
syn keyword markdownEmoticonKeyword :ideograph_advantage: :cl: :sos: :id: :no_entry_sign:
syn keyword markdownEmoticonKeyword :underage: :no_mobile_phones: :do_not_litter: :non-potable_water: :no_bicycles:
syn keyword markdownEmoticonKeyword :no_pedestrians: :children_crossing: :no_entry: :eight_spoked_asterisk: :eight_pointed_black_star:
syn keyword markdownEmoticonKeyword :heart_decoration: :vs: :vibration_mode: :mobile_phone_off: :chart:
syn keyword markdownEmoticonKeyword :currency_exchange: :aries: :taurus: :gemini: :cancer:
syn keyword markdownEmoticonKeyword :leo: :virgo: :libra: :scorpius: :sagittarius:
syn keyword markdownEmoticonKeyword :capricorn: :aquarius: :pisces: :ophiuchus: :six_pointed_star:
syn keyword markdownEmoticonKeyword :negative_squared_cross_mark: :a: :b: :ab: :o2:
syn keyword markdownEmoticonKeyword :diamond_shape_with_a_dot_inside: :recycle: :end: :on: :soon:
syn keyword markdownEmoticonKeyword :clock1: :clock130: :clock10: :clock1030: :clock11:
syn keyword markdownEmoticonKeyword :clock1130: :clock12: :clock1230: :clock2: :clock230:
syn keyword markdownEmoticonKeyword :clock3: :clock330: :clock4: :clock430: :clock5:
syn keyword markdownEmoticonKeyword :clock530: :clock6: :clock630: :clock7: :clock730:
syn keyword markdownEmoticonKeyword :clock8: :clock830: :clock9: :clock930: :heavy_dollar_sign:
syn keyword markdownEmoticonKeyword :copyright: :registered: :tm: :x: :heavy_exclamation_mark:
syn keyword markdownEmoticonKeyword :bangbang: :interrobang: :o: :heavy_multiplication_x: :heavy_plus_sign:
syn keyword markdownEmoticonKeyword :heavy_minus_sign: :heavy_division_sign: :white_flower: :100: :heavy_check_mark:
syn keyword markdownEmoticonKeyword :ballot_box_with_check: :radio_button: :link: :curly_loop: :wavy_dash:
syn keyword markdownEmoticonKeyword :part_alternation_mark: :trident: :black_square: :white_square: :white_check_mark:
syn keyword markdownEmoticonKeyword :black_square_button: :white_square_button: :black_circle: :white_circle: :red_circle:
syn keyword markdownEmoticonKeyword :large_blue_circle: :large_blue_diamond: :large_orange_diamond: :small_blue_diamond: :small_orange_diamond:
syn keyword markdownEmoticonKeyword :small_red_triangle: :small_red_triangle_down: :shipit: :relaxed: :smirk:
syn keyword markdownEmoticonKeyword :heart_eyes: :kissing_heart: :kissing_closed_eyes: :flushed: :relieved:
syn keyword markdownEmoticonKeyword :satisfied: :grin: :wink: :stuck_out_tongue_winking_eye: :stuck_out_tongue_closed_eyes:
syn keyword markdownEmoticonKeyword :grinning: :kissing: :kissing_smiling_eyes: :stuck_out_tongue: :sleeping:
syn keyword markdownEmoticonKeyword :worried: :frowning: :anguished: :open_mouth: :grimacing:
syn keyword markdownEmoticonKeyword :confused: :hushed: :expressionless: :unamused: :sweat_smile:
syn keyword markdownEmoticonKeyword :sweat: :disappointed_relieved: :weary: :pensive: :disappointed:
syn keyword markdownEmoticonKeyword :confounded: :fearful: :cold_sweat: :persevere: :cry:
syn keyword markdownEmoticonKeyword :sob: :joy: :astonished: :scream: :neckbeard:
syn keyword markdownEmoticonKeyword :tired_face: :angry: :rage: :triumph: :sleepy:
syn keyword markdownEmoticonKeyword :yum: :mask: :sunglasses: :dizzy_face: :imp:
syn keyword markdownEmoticonKeyword :smiling_imp: :neutral_face: :no_mouth: :innocent: :alien:
syn keyword markdownEmoticonKeyword :yellow_heart: :blue_heart: :purple_heart: :heart: :green_heart:
syn keyword markdownEmoticonKeyword :broken_heart: :heartbeat: :heartpulse: :two_hearts: :revolving_hearts:
syn keyword markdownEmoticonKeyword :cupid: :sparkling_heart: :sparkles: :star: :star2:
syn keyword markdownEmoticonKeyword :dizzy: :boom: :collision: :anger: :exclamation:
syn keyword markdownEmoticonKeyword :question: :grey_exclamation: :grey_question: :zzz: :dash:
syn keyword markdownEmoticonKeyword :sweat_drops: :notes: :musical_note: :fire: :hankey:
syn keyword markdownEmoticonKeyword :poop: :shit: :+1: :thumbsup: :-1:
syn keyword markdownEmoticonKeyword :thumbsdown: :ok_hand: :punch: :facepunch: :fist:
syn keyword markdownEmoticonKeyword :v: :wave: :hand: :raised_hand: :open_hands:
syn keyword markdownEmoticonKeyword :point_up: :point_down: :point_left: :point_right: :raised_hands:
syn keyword markdownEmoticonKeyword :pray: :point_up_2: :clap: :muscle: :metal:
syn keyword markdownEmoticonKeyword :fu: :walking: :runner: :running: :couple:
syn keyword markdownEmoticonKeyword :family: :two_men_holding_hands: :two_women_holding_hands: :dancer: :dancers:
syn keyword markdownEmoticonKeyword :ok_woman: :no_good: :information_desk_person: :raising_hand: :bride_with_veil:
syn keyword markdownEmoticonKeyword :person_with_pouting_face: :person_frowning: :bow: :couplekiss: :couple_with_heart:
syn keyword markdownEmoticonKeyword :massage: :haircut: :nail_care: :boy: :girl:
syn keyword markdownEmoticonKeyword :woman: :man: :baby: :older_woman: :older_man:
syn keyword markdownEmoticonKeyword :person_with_blond_hair: :man_with_gua_pi_mao: :man_with_turban: :construction_worker: :cop:
syn keyword markdownEmoticonKeyword :angel: :princess: :smiley_cat: :smile_cat: :heart_eyes_cat:
syn keyword markdownEmoticonKeyword :kissing_cat: :smirk_cat: :scream_cat: :crying_cat_face: :joy_cat:
syn keyword markdownEmoticonKeyword :pouting_cat: :japanese_ogre: :japanese_goblin: :see_no_evil: :hear_no_evil:
syn keyword markdownEmoticonKeyword :speak_no_evil: :guardsman: :skull: :feet: :lips:
syn keyword markdownEmoticonKeyword :kiss: :droplet: :ear: :eyes: :nose:
syn keyword markdownEmoticonKeyword :tongue: :love_letter: :bust_in_silhouette: :busts_in_silhouette: :speech_balloon:
syn keyword markdownEmoticonKeyword :thought_balloon: :feelsgood: :finnadie: :goberserk: :godmode:
syn keyword markdownEmoticonKeyword :hurtrealbad: :rage1: :rage2: :rage3: :rage4:
syn keyword markdownEmoticonKeyword :suspect: :trollface: :sunny: :umbrella: :cloud:
syn keyword markdownEmoticonKeyword :snowflake: :snowman: :zap: :cyclone: :foggy:
syn keyword markdownEmoticonKeyword :ocean: :cat: :dog: :mouse: :hamster:
syn keyword markdownEmoticonKeyword :rabbit: :wolf: :frog: :tiger: :koala:
syn keyword markdownEmoticonKeyword :bear: :pig: :pig_nose: :cow: :boar:
syn keyword markdownEmoticonKeyword :monkey_face: :monkey: :horse: :racehorse: :camel:
syn keyword markdownEmoticonKeyword :sheep: :elephant: :panda_face: :snake: :bird:
syn keyword markdownEmoticonKeyword :baby_chick: :hatched_chick: :hatching_chick: :chicken: :penguin:
syn keyword markdownEmoticonKeyword :turtle: :bug: :honeybee: :ant: :beetle:
syn keyword markdownEmoticonKeyword :snail: :octopus: :tropical_fish: :fish: :whale:
syn keyword markdownEmoticonKeyword :whale2: :dolphin: :cow2: :ram: :rat:
syn keyword markdownEmoticonKeyword :water_buffalo: :tiger2: :rabbit2: :dragon: :goat:
syn keyword markdownEmoticonKeyword :rooster: :dog2: :pig2: :mouse2: :ox:
syn keyword markdownEmoticonKeyword :dragon_face: :blowfish: :crocodile: :dromedary_camel: :leopard:
syn keyword markdownEmoticonKeyword :cat2: :poodle: :paw_prints: :bouquet: :cherry_blossom:
syn keyword markdownEmoticonKeyword :tulip: :four_leaf_clover: :rose: :sunflower: :hibiscus:
syn keyword markdownEmoticonKeyword :maple_leaf: :leaves: :fallen_leaf: :herb: :mushroom:
syn keyword markdownEmoticonKeyword :cactus: :palm_tree: :evergreen_tree: :deciduous_tree: :chestnut:
syn keyword markdownEmoticonKeyword :seedling: :blossom: :ear_of_rice: :shell: :globe_with_meridians:
syn keyword markdownEmoticonKeyword :sun_with_face: :full_moon_with_face: :new_moon_with_face: :new_moon: :waxing_crescent_moon:
syn keyword markdownEmoticonKeyword :first_quarter_moon: :waxing_gibbous_moon: :full_moon: :waning_gibbous_moon: :last_quarter_moon:
syn keyword markdownEmoticonKeyword :waning_crescent_moon: :last_quarter_moon_with_face: :first_quarter_moon_with_face: :moon: :earth_africa:
syn keyword markdownEmoticonKeyword :earth_americas: :earth_asia: :volcano: :milky_way: :partly_sunny:
syn keyword markdownEmoticonKeyword :octocat: :squirrel: :bamboo: :gift_heart: :dolls:
syn keyword markdownEmoticonKeyword :school_satchel: :mortar_board: :flags: :fireworks: :sparkler:
syn keyword markdownEmoticonKeyword :wind_chime: :rice_scene: :jack_o_lantern: :ghost: :santa:
syn keyword markdownEmoticonKeyword :christmas_tree: :gift: :bell: :no_bell: :tanabata_tree:
syn keyword markdownEmoticonKeyword :tada: :confetti_ball: :balloon: :crystal_ball: :cd:
syn keyword markdownEmoticonKeyword :dvd: :floppy_disk: :camera: :video_camera: :movie_camera:
syn keyword markdownEmoticonKeyword :computer: :tv: :iphone: :phone: :telephone:
syn keyword markdownEmoticonKeyword :telephone_receiver: :pager: :fax: :minidisc: :vhs:
syn keyword markdownEmoticonKeyword :sound: :speaker: :mute: :loudspeaker: :mega:
syn keyword markdownEmoticonKeyword :hourglass: :hourglass_flowing_sand: :alarm_clock: :watch: :radio:
syn keyword markdownEmoticonKeyword :satellite: :loop: :mag: :mag_right: :unlock:
syn keyword markdownEmoticonKeyword :lock: :lock_with_ink_pen: :closed_lock_with_key: :key: :bulb:
syn keyword markdownEmoticonKeyword :flashlight: :high_brightness: :low_brightness: :electric_plug: :battery:
syn keyword markdownEmoticonKeyword :calling: :email: :mailbox: :postbox: :bath:
syn keyword markdownEmoticonKeyword :bathtub: :shower: :toilet: :wrench: :nut_and_bolt:
syn keyword markdownEmoticonKeyword :hammer: :seat: :moneybag: :yen: :dollar:
syn keyword markdownEmoticonKeyword :pound: :euro: :credit_card: :money_with_wings: :e-mail:
syn keyword markdownEmoticonKeyword :inbox_tray: :outbox_tray: :envelope: :incoming_envelope: :postal_horn:
syn keyword markdownEmoticonKeyword :mailbox_closed: :mailbox_with_mail: :mailbox_with_no_mail: :door: :smoking:
syn keyword markdownEmoticonKeyword :bomb: :gun: :hocho: :pill: :syringe:
syn keyword markdownEmoticonKeyword :page_facing_up: :page_with_curl: :bookmark_tabs: :bar_chart: :chart_with_upwards_trend:
syn keyword markdownEmoticonKeyword :chart_with_downwards_trend: :scroll: :clipboard: :calendar: :date:
syn keyword markdownEmoticonKeyword :card_index: :file_folder: :open_file_folder: :scissors: :pushpin:
syn keyword markdownEmoticonKeyword :paperclip: :black_nib: :pencil2: :straight_ruler: :triangular_ruler:
syn keyword markdownEmoticonKeyword :closed_book: :green_book: :blue_book: :orange_book: :notebook:
syn keyword markdownEmoticonKeyword :notebook_with_decorative_cover: :ledger: :books: :bookmark: :name_badge:
syn keyword markdownEmoticonKeyword :microscope: :telescope: :newspaper: :football: :basketball:
syn keyword markdownEmoticonKeyword :soccer: :baseball: :tennis: :8ball: :rugby_football:
syn keyword markdownEmoticonKeyword :bowling: :golf: :mountain_bicyclist: :bicyclist: :horse_racing:
syn keyword markdownEmoticonKeyword :snowboarder: :swimmer: :surfer: :ski: :spades:
syn keyword markdownEmoticonKeyword :hearts: :clubs: :diamonds: :gem: :ring:
syn keyword markdownEmoticonKeyword :trophy: :musical_score: :musical_keyboard: :violin: :space_invader:
syn keyword markdownEmoticonKeyword :video_game: :black_joker: :flower_playing_cards: :game_die: :dart:
syn keyword markdownEmoticonKeyword :mahjong: :clapper: :memo: :pencil: :book:
syn keyword markdownEmoticonKeyword :art: :microphone: :headphones: :trumpet: :saxophone:
syn keyword markdownEmoticonKeyword :guitar: :shoe: :sandal: :high_heel: :lipstick:
syn keyword markdownEmoticonKeyword :boot: :shirt: :tshirt: :necktie: :womans_clothes:
syn keyword markdownEmoticonKeyword :dress: :running_shirt_with_sash: :jeans: :kimono: :bikini:
syn keyword markdownEmoticonKeyword :ribbon: :tophat: :crown: :womans_hat: :mans_shoe:
syn keyword markdownEmoticonKeyword :closed_umbrella: :briefcase: :handbag: :pouch: :purse:
syn keyword markdownEmoticonKeyword :eyeglasses: :fishing_pole_and_fish: :coffee: :tea: :sake:
syn keyword markdownEmoticonKeyword :baby_bottle: :beer: :beers: :cocktail: :tropical_drink:
syn keyword markdownEmoticonKeyword :wine_glass: :fork_and_knife: :pizza: :hamburger: :fries:
syn keyword markdownEmoticonKeyword :poultry_leg: :meat_on_bone: :spaghetti: :curry: :fried_shrimp:
syn keyword markdownEmoticonKeyword :bento: :sushi: :fish_cake: :rice_ball: :rice_cracker:
syn keyword markdownEmoticonKeyword :rice: :ramen: :stew: :oden: :dango:
syn keyword markdownEmoticonKeyword :egg: :bread: :doughnut: :custard: :icecream:
syn keyword markdownEmoticonKeyword :ice_cream: :shaved_ice: :birthday: :cake: :cookie:
syn keyword markdownEmoticonKeyword :chocolate_bar: :candy: :lollipop: :honey_pot: :apple:
syn keyword markdownEmoticonKeyword :green_apple: :tangerine: :lemon: :cherries: :grapes:
syn keyword markdownEmoticonKeyword :watermelon: :strawberry: :peach: :melon: :banana:
syn keyword markdownEmoticonKeyword :pear: :pineapple: :sweet_potato: :eggplant: :tomato:
syn keyword markdownEmoticonKeyword :corn: :house: :house_with_garden: :school: :office:
syn keyword markdownEmoticonKeyword :post_office: :hospital: :bank: :convenience_store: :love_hotel:
syn keyword markdownEmoticonKeyword :hotel: :wedding: :church: :department_store: :european_post_office:
syn keyword markdownEmoticonKeyword :city_sunrise: :city_sunset: :japanese_castle: :european_castle: :tent:
syn keyword markdownEmoticonKeyword :factory: :tokyo_tower: :japan: :mount_fuji: :sunrise_over_mountains:
syn keyword markdownEmoticonKeyword :sunrise: :stars: :statue_of_liberty: :bridge_at_night: :carousel_horse:
syn keyword markdownEmoticonKeyword :rainbow: :ferris_wheel: :fountain: :roller_coaster: :ship:
syn keyword markdownEmoticonKeyword :speedboat: :boat: :sailboat: :rowboat: :anchor:
syn keyword markdownEmoticonKeyword :rocket: :airplane: :helicopter: :steam_locomotive: :tram:
syn keyword markdownEmoticonKeyword :mountain_railway: :bike: :aerial_tramway: :suspension_railway: :mountain_cableway:
syn keyword markdownEmoticonKeyword :tractor: :blue_car: :oncoming_automobile: :car: :red_car:
syn keyword markdownEmoticonKeyword :taxi: :oncoming_taxi: :articulated_lorry: :bus: :oncoming_bus:
syn keyword markdownEmoticonKeyword :rotating_light: :police_car: :oncoming_police_car: :fire_engine: :ambulance:
syn keyword markdownEmoticonKeyword :minibus: :truck: :train: :station: :train2:
syn keyword markdownEmoticonKeyword :bullettrain_front: :bullettrain_side: :light_rail: :monorail: :railway_car:
syn keyword markdownEmoticonKeyword :trolleybus: :ticket: :fuelpump: :vertical_traffic_light: :traffic_light:
syn keyword markdownEmoticonKeyword :warning: :construction: :beginner: :atm: :slot_machine:
syn keyword markdownEmoticonKeyword :busstop: :barber: :hotsprings: :checkered_flag: :crossed_flags:
syn keyword markdownEmoticonKeyword :izakaya_lantern: :moyai: :circus_tent: :performing_arts: :round_pushpin:
syn keyword markdownEmoticonKeyword :triangular_flag_on_post: :jp: :kr: :cn: :us:
syn keyword markdownEmoticonKeyword :fr: :es: :it: :ru: :gb:
syn keyword markdownEmoticonKeyword :uk: :de: :one: :two: :three:
syn keyword markdownEmoticonKeyword :four: :five: :six: :seven: :eight:
syn keyword markdownEmoticonKeyword :nine: :keycap_ten: :1234: :zero: :hash:
syn keyword markdownEmoticonKeyword :symbols: :arrow_backward: :arrow_down: :arrow_forward: :arrow_left:
syn keyword markdownEmoticonKeyword :capital_abcd: :abcd: :abc: :arrow_lower_left: :arrow_lower_right:
syn keyword markdownEmoticonKeyword :arrow_right: :arrow_up: :arrow_upper_left: :arrow_upper_right: :arrow_double_down:
syn keyword markdownEmoticonKeyword :arrow_double_up: :arrow_down_small: :arrow_heading_down: :arrow_heading_up: :leftwards_arrow_with_hook:
syn keyword markdownEmoticonKeyword :arrow_right_hook: :left_right_arrow: :arrow_up_down: :arrow_up_small: :arrows_clockwise:
syn keyword markdownEmoticonKeyword :arrows_counterclockwise: :rewind: :fast_forward: :information_source: :ok:
syn keyword markdownEmoticonKeyword :twisted_rightwards_arrows: :repeat: :repeat_one: :new: :top:
syn keyword markdownEmoticonKeyword :up: :cool: :free: :ng: :cinema:
syn keyword markdownEmoticonKeyword :koko: :signal_strength: :u5272: :u5408: :u55b6:
syn keyword markdownEmoticonKeyword :u6307: :u6708: :u6709: :u6e80: :u7121:
syn keyword markdownEmoticonKeyword :u7533: :u7a7a: :u7981: :sa: :restroom:
syn keyword markdownEmoticonKeyword :mens: :womens: :baby_symbol: :no_smoking: :parking:
syn keyword markdownEmoticonKeyword :wheelchair: :metro: :baggage_claim: :accept: :wc:
syn keyword markdownEmoticonKeyword :potable_water: :put_litter_in_its_place: :secret: :congratulations: :m:
syn keyword markdownEmoticonKeyword :passport_control: :left_luggage: :customs: :ideograph_advantage: :cl:
syn keyword markdownEmoticonKeyword :sos: :id: :no_entry_sign: :underage: :no_mobile_phones:
syn keyword markdownEmoticonKeyword :do_not_litter: :non-potable_water: :no_bicycles: :no_pedestrians: :children_crossing:
syn keyword markdownEmoticonKeyword :no_entry: :eight_spoked_asterisk: :eight_pointed_black_star: :heart_decoration: :vs:
syn keyword markdownEmoticonKeyword :vibration_mode: :mobile_phone_off: :chart: :currency_exchange: :aries:
syn keyword markdownEmoticonKeyword :taurus: :gemini: :cancer: :leo: :virgo:
syn keyword markdownEmoticonKeyword :libra: :scorpius: :sagittarius: :capricorn: :aquarius:
syn keyword markdownEmoticonKeyword :pisces: :ophiuchus: :six_pointed_star: :negative_squared_cross_mark: :a:
syn keyword markdownEmoticonKeyword :b: :ab: :o2: :diamond_shape_with_a_dot_inside: :recycle:
syn keyword markdownEmoticonKeyword :end: :on: :soon: :clock1: :clock130:
syn keyword markdownEmoticonKeyword :clock10: :clock1030: :clock11: :clock1130: :clock12:
syn keyword markdownEmoticonKeyword :clock1230: :clock2: :clock230: :clock3: :clock330:
syn keyword markdownEmoticonKeyword :clock4: :clock430: :clock5: :clock530: :clock6:
syn keyword markdownEmoticonKeyword :clock630: :clock7: :clock730: :clock8: :clock830:
syn keyword markdownEmoticonKeyword :clock9: :clock930: :heavy_dollar_sign: :copyright: :registered:
syn keyword markdownEmoticonKeyword :tm: :x: :heavy_exclamation_mark: :bangbang: :interrobang:
syn keyword markdownEmoticonKeyword :o: :heavy_multiplication_x: :heavy_plus_sign: :heavy_minus_sign: :heavy_division_sign:
syn keyword markdownEmoticonKeyword :white_flower: :100: :heavy_check_mark: :ballot_box_with_check: :radio_button:
syn keyword markdownEmoticonKeyword :link: :curly_loop: :wavy_dash: :part_alternation_mark: :trident:
syn keyword markdownEmoticonKeyword :black_square: :white_square: :white_check_mark: :black_square_button: :white_square_button:
syn keyword markdownEmoticonKeyword :black_circle: :white_circle: :red_circle: :large_blue_circle: :large_blue_diamond:
syn keyword markdownEmoticonKeyword :large_orange_diamond: :small_blue_diamond: :small_orange_diamond: :small_red_triangle: :small_red_triangle_down:
syn keyword markdownEmoticonKeyword :shipit:

hi def Italic                       term=italic cterm=italic gui=italic
hi def Bold                         term=bold cterm=bold gui=bold
hi def BoldItalic                   term=bold,italic cterm=bold,italic gui=bold,italic

hi def link markdownItalic                  Italic
hi def link markdownBold                    Bold
hi def link markdownBoldItalic              BoldItalic

hi def link markdownPullRequestLinkInText   Underlined
hi def link markdownUserLinkInText          Underlined
hi def link markdownUrlLinkInText           Underlined
hi def link markdownEmailLinkInText         Underlined

hi def link markdownLinkText                Underlined
hi def link markdownLinkUrl                 Underlined
hi def link markdownLinkTitleSingleQuoted   Bold
hi def link markdownLinkTitleDoubleQuoted   Bold
hi def link markdownLinkUrlContainer        Delimiter
hi def link markdownLinkTextContainer       Delimiter
hi def link markdownLinkReference           Bold

hi def link markdownCodeDelimiter           Delimiter
hi def link markdownCode                    String

hi def link markdownStrike                  NonText
hi def link markdownStrikeDelimiter         Delimiter
hi def link markdownBlockquote              Comment
hi def link markdownBlockquoteDelimiter     Delimiter
hi def link markdownHeadingDelimiter        Delimiter
hi def link markdownHeadingUnderline        Delimiter
hi def link markdownInlineDelimiter         Delimiter
hi def link markdownListDelimiter           Delimiter
hi def link markdownH1                      Title
hi def link markdownH2                      Title
hi def link markdownH3                      Title
hi def link markdownH4                      Title
hi def link markdownH5                      Title
hi def link markdownH6                      Title
hi def link markdownEmoticonKeyword         Statement
hi def link markdownRule                    Identifier

hi def link markdownXmlComment              NonText
hi def link markdownXmlElement              NonText
hi def link markdownXmlEmptyElement         NonText
hi def link markdownXmlEntities             Special

let b:current_syntax = "markdown"
