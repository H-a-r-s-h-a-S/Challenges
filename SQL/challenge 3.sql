-- https://www.linkedin.com/posts/gauravowlcity_zomato-sql-analytics-activity-7136679212567953408-nTmf?utm_source=share&utm_medium=member_ios

-- table - order_fact
-- columns - order_id, cust_id, city_id, order_date, order_status ( canceled, delivered) ,order_value
-- task: find customers who have not made any order in last 90 days

drop database if exists challenges ;
create schema challenges ;
use challenges ;

drop table if exists order_fact ;
create table order_fact (
	order_id int AUTO_INCREMENT,
	cust_id int,
	city_id int,
	order_date date,
	order_status varchar(20),
	order_value decimal,
	primary key (order_id)
) ;

insert into order_fact (cust_id, city_id, order_date, order_status, order_value) values (43,20,'2023-01-01','cancelled',227.314733443522), (7,19,'2023-01-02','delivered',396.020740373207), (55,8,'2023-01-03','delivered',235.258045346011), (21,14,'2023-01-04','cancelled',59.2423846826219), (91,16,'2023-01-05','delivered',246.199299893199), (36,11,'2023-01-06','cancelled',361.998315431258), (78,1,'2023-01-07','delivered',734.592079958716), (37,2,'2023-01-08','delivered',235.234514026922), (17,10,'2023-01-09','cancelled',954.254618986023), (69,20,'2023-01-10','cancelled',968.682339931056), (75,3,'2023-01-11','delivered',584.396210728517), (5,17,'2023-01-12','cancelled',111.06288002238), (84,13,'2023-01-13','delivered',247.694963202598), (10,20,'2023-01-14','cancelled',468.589352184494), (51,11,'2023-01-15','delivered',676.434412945837), (45,11,'2023-01-16','delivered',314.942157756766), (87,5,'2023-01-17','cancelled',227.42656293613), (49,9,'2023-01-18','delivered',599.30016247457), (38,10,'2023-01-19','cancelled',952.350318564307), (21,7,'2023-01-20','delivered',591.39551762023), (78,2,'2023-01-21','cancelled',313.025555430241), (11,16,'2023-01-22','delivered',507.355223388134), (64,7,'2023-01-23','cancelled',193.315782842622), (85,7,'2023-01-24','delivered',706.340585932211), (33,12,'2023-01-25','cancelled',777.491995487774), (65,3,'2023-01-26','delivered',903.608079250769), (36,20,'2023-01-27','delivered',379.660930549033), (44,16,'2023-01-28','cancelled',82.8933169827594), (83,6,'2023-01-29','delivered',483.567202172941), (45,16,'2023-01-30','delivered',932.365343960899), (62,2,'2023-01-31','cancelled',343.218663322163), (81,4,'2023-02-01','cancelled',462.528182334193), (7,11,'2023-02-02','cancelled',494.176928613372), (34,13,'2023-02-03','cancelled',199.711596888205), (72,12,'2023-02-04','delivered',126.880916177649), (45,3,'2023-02-05','delivered',861.023557625948), (4,10,'2023-02-06','cancelled',303.45769458491), (48,16,'2023-02-07','cancelled',904.117610070956), (73,12,'2023-02-08','cancelled',329.547994995953), (55,20,'2023-02-09','cancelled',141.17372800142), (69,9,'2023-02-10','delivered',117.801534483816), (30,10,'2023-02-11','cancelled',377.901607231119), (45,18,'2023-02-12','cancelled',104.756336858163), (16,9,'2023-02-13','delivered',324.665886140549), (48,14,'2023-02-14','cancelled',29.6054453759041), (32,6,'2023-02-15','cancelled',446.974750843703), (93,17,'2023-02-16','cancelled',16.8003258392601), (69,15,'2023-02-17','cancelled',652.217702266354), (9,9,'2023-02-18','delivered',387.809845990002), (56,10,'2023-02-19','delivered',854.040693584268), (81,14,'2023-02-20','delivered',464.296303933396), (49,6,'2023-02-21','cancelled',616.021191740221), (18,8,'2023-02-22','delivered',436.615136423474), (59,17,'2023-02-23','cancelled',950.260579911957), (13,16,'2023-02-24','delivered',337.913267768757), (52,17,'2023-02-25','delivered',275.231276801364), (43,20,'2023-02-26','cancelled',64.5226036690978), (74,2,'2023-02-27','cancelled',708.693121164953), (68,4,'2023-02-28','cancelled',458.107482739948), (98,8,'2023-03-01','delivered',593.158924011867), (48,14,'2023-03-02','delivered',463.120783806702), (83,12,'2023-03-03','delivered',943.366333961388), (70,5,'2023-03-04','delivered',387.342209362604), (99,11,'2023-03-05','delivered',696.656325264562), (80,3,'2023-03-06','cancelled',79.2679715668886), (35,9,'2023-03-07','cancelled',206.177312521682), (59,10,'2023-03-08','cancelled',54.6193061709712), (1,14,'2023-03-09','cancelled',501.140447235826), (23,3,'2023-03-10','cancelled',971.70971584684), (22,12,'2023-03-11','cancelled',994.199514525412), (19,11,'2023-03-12','delivered',369.253966112462), (37,13,'2023-03-13','cancelled',173.246298537152), (18,8,'2023-03-14','cancelled',566.333670124971), (60,3,'2023-03-15','delivered',975.020677057935), (41,4,'2023-03-16','delivered',952.855569002564), (17,17,'2023-03-17','cancelled',214.913291984487), (72,6,'2023-03-18','delivered',370.418806893142), (81,5,'2023-03-19','cancelled',821.00078907388), (59,7,'2023-03-20','delivered',267.348137923855), (39,17,'2023-03-21','delivered',898.734946477326), (14,14,'2023-03-22','cancelled',590.613217452251), (47,1,'2023-03-23','delivered',813.552493369452), (45,7,'2023-03-24','delivered',857.636255816906), (74,20,'2023-03-25','delivered',244.934610413707), (53,5,'2023-03-26','cancelled',380.811702565932), (70,18,'2023-03-27','delivered',655.36567089769), (57,10,'2023-03-28','delivered',319.8676429447), (36,7,'2023-03-29','cancelled',604.519725687041), (96,10,'2023-03-30','cancelled',129.772955986577), (60,14,'2023-03-31','cancelled',190.958093755634), (62,18,'2023-04-01','cancelled',632.651419206103), (33,15,'2023-04-02','cancelled',367.087695138832), (62,17,'2023-04-03','cancelled',773.416452420639), (25,19,'2023-04-04','cancelled',387.164298942245), (78,19,'2023-04-05','cancelled',339.688968186146), (91,8,'2023-04-06','delivered',529.768709100979), (17,7,'2023-04-07','cancelled',883.498794337867), (27,18,'2023-04-08','cancelled',958.777837408317), (42,14,'2023-04-09','delivered',654.764738638299), (24,17,'2023-04-10','delivered',973.129944213731), (17,18,'2023-04-11','delivered',45.2610723520476), (78,12,'2023-04-12','delivered',247.519718580712), (7,3,'2023-04-13','cancelled',131.844544397519), (79,5,'2023-04-14','cancelled',27.648895757547), (39,10,'2023-04-15','cancelled',377.020114942049), (5,6,'2023-04-16','cancelled',398.695085138931), (52,1,'2023-04-17','delivered',366.422995114353), (59,6,'2023-04-18','cancelled',584.873934543365), (58,11,'2023-04-19','delivered',33.1317791347491), (77,3,'2023-04-20','cancelled',348.497598053458), (70,14,'2023-04-21','cancelled',766.114990110305), (79,16,'2023-04-22','cancelled',806.109757682235), (48,13,'2023-04-23','delivered',281.791463993399), (76,9,'2023-04-24','cancelled',30.5871784153018), (95,14,'2023-04-25','cancelled',183.053577533377), (4,14,'2023-04-26','cancelled',461.152714733316), (51,10,'2023-04-27','delivered',939.825701356359), (54,17,'2023-04-28','cancelled',225.926450322435), (47,1,'2023-04-29','cancelled',232.574314734066), (37,4,'2023-04-30','cancelled',674.445322522988), (76,10,'2023-05-01','delivered',622.691319793982), (49,1,'2023-05-02','cancelled',845.710533744641), (56,15,'2023-05-03','cancelled',69.3691510218994), (81,1,'2023-05-04','delivered',852.687322063786), (23,4,'2023-05-05','delivered',91.5730682278264), (2,14,'2023-05-06','delivered',590.436472590806), (69,5,'2023-05-07','cancelled',998.599537206493), (53,19,'2023-05-08','cancelled',739.525758056037), (42,15,'2023-05-09','cancelled',263.023816486259), (72,20,'2023-05-10','delivered',421.763782699129), (79,1,'2023-05-11','delivered',602.542302503788), (86,19,'2023-05-12','delivered',9.5249485509557), (72,2,'2023-05-13','cancelled',432.422508870604), (6,19,'2023-05-14','delivered',62.5413553641077), (97,6,'2023-05-15','delivered',36.8292145142571), (28,20,'2023-05-16','delivered',338.819048739902), (81,6,'2023-05-17','delivered',613.968179081702), (36,18,'2023-05-18','cancelled',21.7519344815043), (59,8,'2023-05-19','delivered',310.245568574003), (20,5,'2023-05-20','delivered',854.096767357046), (81,16,'2023-05-21','delivered',63.3105905532211), (20,1,'2023-05-22','delivered',247.424834127411), (22,3,'2023-05-23','cancelled',546.7295040341), (33,16,'2023-05-24','delivered',849.383467264217), (68,6,'2023-05-25','cancelled',657.462753802684), (53,15,'2023-05-26','cancelled',28.4426605287896), (44,18,'2023-05-27','cancelled',823.588934162838), (77,5,'2023-05-28','cancelled',260.258833532749), (69,16,'2023-05-29','delivered',743.246645133615), (96,10,'2023-05-30','cancelled',296.67672368753), (68,14,'2023-05-31','cancelled',706.670774814255), (4,16,'2023-06-01','cancelled',979.306807687311), (22,15,'2023-06-02','cancelled',581.888977788459), (76,13,'2023-06-03','delivered',644.385602956771), (68,5,'2023-06-04','delivered',370.563497742609), (42,18,'2023-06-05','delivered',697.220139048618), (9,4,'2023-06-06','cancelled',511.355575949065), (76,4,'2023-06-07','delivered',920.133392007161), (50,11,'2023-06-08','delivered',84.8315355689638), (94,15,'2023-06-09','cancelled',283.588241460089), (9,20,'2023-06-10','delivered',312.475669845957), (32,17,'2023-06-11','delivered',689.484045234861), (77,13,'2023-06-12','cancelled',59.6063145710177), (26,5,'2023-06-13','delivered',182.968975390281), (34,8,'2023-06-14','cancelled',140.999321300471), (38,18,'2023-06-15','cancelled',540.122945721853), (77,7,'2023-06-16','delivered',698.537504417818), (28,10,'2023-06-17','delivered',399.971034631218), (53,4,'2023-06-18','cancelled',613.256970039872), (14,18,'2023-06-19','delivered',235.119894949957), (87,15,'2023-06-20','delivered',44.1629145114341), (30,14,'2023-06-21','delivered',171.035370747129), (36,20,'2023-06-22','cancelled',469.306751213712), (11,14,'2023-06-23','delivered',427.023086226195), (65,19,'2023-06-24','delivered',477.105368484631), (85,20,'2023-06-25','delivered',809.294894005858), (25,20,'2023-06-26','delivered',820.546782711805), (42,18,'2023-06-27','delivered',253.68480356393), (47,15,'2023-06-28','cancelled',553.545478789843), (25,2,'2023-06-29','delivered',366.746699767757), (62,15,'2023-06-30','cancelled',530.293816319329), (62,19,'2023-07-01','delivered',662.831129091976), (56,5,'2023-07-02','delivered',495.169877831422), (84,9,'2023-07-03','delivered',665.07967857611), (88,3,'2023-07-04','delivered',266.368841607158), (91,18,'2023-07-05','delivered',946.950235079698), (49,1,'2023-07-06','cancelled',930.969410618608), (5,13,'2023-07-07','delivered',950.015887973537), (62,11,'2023-07-08','delivered',246.286895338573), (96,2,'2023-07-09','delivered',62.4763726712545), (77,1,'2023-07-10','delivered',63.3533723582864), (70,4,'2023-07-11','cancelled',823.070673272398), (53,2,'2023-07-12','cancelled',779.488211651216), (57,9,'2023-07-13','delivered',307.177788844421), (80,6,'2023-07-14','cancelled',128.892136336589), (16,5,'2023-07-15','cancelled',714.863833590975), (53,8,'2023-07-16','cancelled',729.292664999742), (4,2,'2023-07-17','cancelled',27.3109910308228), (26,20,'2023-07-18','delivered',360.48852107967), (56,4,'2023-07-19','cancelled',547.707729325328), (91,11,'2023-07-20','delivered',911.60006539032), (2,15,'2023-07-21','delivered',450.316237299315), (93,9,'2023-07-22','cancelled',569.927998279347), (89,9,'2023-07-23','delivered',884.3058165866), (54,3,'2023-07-24','cancelled',895.818056972836), (97,8,'2023-07-25','cancelled',876.278428761943), (48,10,'2023-07-26','delivered',262.819373865148), (56,6,'2023-07-27','cancelled',677.836736056061), (22,8,'2023-07-28','delivered',158.60883525529), (10,19,'2023-07-29','cancelled',882.454897927054), (54,18,'2023-07-30','cancelled',29.8056682630009), (63,5,'2023-07-31','cancelled',780.910671087089), (58,17,'2023-08-01','cancelled',985.538326934094), (38,6,'2023-08-02','delivered',151.33239803914), (32,14,'2023-08-03','cancelled',451.753024744916), (58,17,'2023-08-04','cancelled',925.211985596665), (17,8,'2023-08-05','delivered',159.203695694187), (79,9,'2023-08-06','delivered',551.327132566952), (46,8,'2023-08-07','delivered',845.142439252869), (68,13,'2023-08-08','delivered',65.596136116913), (24,15,'2023-08-09','delivered',811.216189676352), (7,17,'2023-08-10','cancelled',166.508169200266), (78,17,'2023-08-11','cancelled',70.8726944251128), (71,18,'2023-08-12','cancelled',921.722016133905), (83,15,'2023-08-13','delivered',874.649208386067), (77,18,'2023-08-14','delivered',532.035993743118), (29,7,'2023-08-15','cancelled',389.088383938381), (61,15,'2023-08-16','cancelled',513.263481181226), (78,12,'2023-08-17','cancelled',764.7621059037), (90,18,'2023-08-18','cancelled',613.507013958781), (7,13,'2023-08-19','delivered',493.039805481005), (82,20,'2023-08-20','delivered',551.577490226825), (60,13,'2023-08-21','cancelled',846.43976806784), (12,4,'2023-08-22','delivered',866.656450518004), (52,1,'2023-08-23','delivered',630.339112445074), (62,11,'2023-08-24','delivered',460.050657734529), (46,20,'2023-08-25','delivered',184.680691144495), (8,2,'2023-08-26','delivered',602.936755270407), (22,18,'2023-08-27','delivered',440.458636230346), (86,14,'2023-08-28','delivered',594.342399491369), (60,3,'2023-08-29','delivered',435.514680625119), (36,2,'2023-08-30','delivered',142.699131376451), (45,2,'2023-08-31','delivered',76.0651287919026), (83,15,'2023-09-01','delivered',944.176306660875), (42,19,'2023-09-02','delivered',34.202573929539), (46,20,'2023-09-03','delivered',243.45298526065), (26,6,'2023-09-04','delivered',485.94939042397), (68,10,'2023-09-05','delivered',104.688198387366), (51,2,'2023-09-06','cancelled',715.217954316469), (18,9,'2023-09-07','delivered',675.689857545482), (69,12,'2023-09-08','delivered',98.6551390578103), (23,7,'2023-09-09','cancelled',898.357076647888), (71,6,'2023-09-10','delivered',590.338716699579), (88,20,'2023-09-11','cancelled',668.16165392191), (68,15,'2023-09-12','delivered',399.652692408809), (68,17,'2023-09-13','delivered',890.307998571031), (75,9,'2023-09-14','delivered',148.457133216504), (10,12,'2023-09-15','cancelled',443.977484610239), (69,5,'2023-09-16','cancelled',472.642953133945), (47,18,'2023-09-17','delivered',514.44648257021), (21,20,'2023-09-18','cancelled',537.546622541422), (78,16,'2023-09-19','delivered',758.146064965412), (39,16,'2023-09-20','delivered',825.901069323396), (84,10,'2023-09-21','delivered',773.530849299166), (42,19,'2023-09-22','delivered',874.473995479776), (30,11,'2023-09-23','cancelled',390.935669688402), (43,2,'2023-09-24','delivered',67.9894347270121), (47,20,'2023-09-25','cancelled',635.671232548943), (66,6,'2023-09-26','delivered',453.465143456869), (15,6,'2023-09-27','delivered',792.817536993129), (71,17,'2023-09-28','delivered',598.872317477732), (56,11,'2023-09-29','delivered',496.395919884678), (63,5,'2023-09-30','cancelled',550.858795154473), (78,7,'2023-10-01','cancelled',635.8248266321), (52,14,'2023-10-02','delivered',810.852916504331), (64,1,'2023-10-03','delivered',489.605067737354), (3,9,'2023-10-04','delivered',918.343063912919), (1,9,'2023-10-05','delivered',640.175930124321), (22,7,'2023-10-06','delivered',552.620571533839), (1,1,'2023-10-07','delivered',928.328439105755), (43,8,'2023-10-08','cancelled',334.61500855979), (80,3,'2023-10-09','delivered',460.263179390094), (56,11,'2023-10-10','cancelled',245.45813715411), (3,13,'2023-10-11','cancelled',959.052545741992), (87,13,'2023-10-12','cancelled',491.657947578256), (70,11,'2023-10-13','cancelled',462.643319900401), (6,12,'2023-10-14','delivered',190.254561560597), (59,12,'2023-10-15','delivered',18.915893352539), (65,16,'2023-10-16','cancelled',812.715313345437), (48,17,'2023-10-17','cancelled',773.893876924968), (30,6,'2023-10-18','cancelled',434.129059300763), (72,18,'2023-10-19','cancelled',686.908667116168), (40,5,'2023-10-20','delivered',785.280776132809), (91,8,'2023-10-21','delivered',883.676288808349), (44,15,'2023-10-22','delivered',59.2397718306115), (60,9,'2023-10-23','cancelled',624.478286373205), (36,15,'2023-10-24','delivered',412.149425635358), (35,17,'2023-10-25','cancelled',147.227848704596), (29,13,'2023-10-26','cancelled',957.076809459635), (56,20,'2023-10-27','delivered',481.200136343367), (91,8,'2023-10-28','delivered',153.809567096929), (35,7,'2023-10-29','cancelled',204.680647418477), (19,5,'2023-10-30','delivered',733.006377656682), (88,19,'2023-10-31','cancelled',646.138086197373), (7,9,'2023-11-01','cancelled',449.845166516131), (79,19,'2023-11-02','delivered',910.935147804348), (69,15,'2023-11-03','delivered',7.90043293049243), (13,11,'2023-11-04','cancelled',464.264125821911), (77,8,'2023-11-05','delivered',712.082454941281), (80,4,'2023-11-06','cancelled',530.224584925197), (98,15,'2023-11-07','delivered',830.828757975146), (82,13,'2023-11-08','delivered',995.878494774767), (54,11,'2023-11-09','delivered',569.406068610896), (72,16,'2023-11-10','cancelled',374.330646955703), (54,12,'2023-11-11','delivered',577.322377399878), (43,11,'2023-11-12','cancelled',671.635689215054), (32,5,'2023-11-13','cancelled',863.299183256156), (21,4,'2023-11-14','delivered',71.4584215029763), (3,5,'2023-11-15','cancelled',834.057369024406), (72,1,'2023-11-16','cancelled',183.81018716425), (14,11,'2023-11-17','cancelled',720.436290899216), (98,20,'2023-11-18','delivered',98.2834130862848), (38,19,'2023-11-19','cancelled',817.405053256768), (63,15,'2023-11-20','cancelled',688.758905061691), (42,11,'2023-11-21','cancelled',452.001958042347), (12,15,'2023-11-22','delivered',895.584947775921), (38,13,'2023-11-23','delivered',243.697222595034), (68,5,'2023-11-24','cancelled',33.8858431507872), (45,6,'2023-11-25','cancelled',802.92616774865), (40,13,'2023-11-26','delivered',562.516733870958), (88,20,'2023-11-27','cancelled',369.969786653106), (78,13,'2023-11-28','delivered',5.05235314053238), (95,17,'2023-11-29','delivered',657.181982052155), (32,20,'2023-11-30','delivered',18.4761774026392), (13,3,'2023-12-01','cancelled',193.97672486411), (72,2,'2023-12-02','delivered',31.8327160788818), (30,5,'2023-12-03','cancelled',655.529140616739), (40,17,'2023-12-04','cancelled',574.087451318856), (96,6,'2023-12-05','delivered',373.807667430817), (51,19,'2023-12-06','cancelled',776.852355978368), (12,20,'2023-12-07','delivered',942.308322828854), (59,16,'2023-12-08','cancelled',132.935441988669), (30,12,'2023-12-09','cancelled',687.848692821404), (29,14,'2023-12-10','delivered',135.43687952971), (3,19,'2023-12-11','delivered',606.644486310645), (79,20,'2023-12-12','delivered',336.304341182587), (61,12,'2023-12-13','delivered',986.476997627838), (76,13,'2023-12-14','cancelled',121.795481025722), (29,10,'2023-12-15','cancelled',674.559223700886), (19,2,'2023-12-16','cancelled',894.777982969122), (36,16,'2023-12-17','cancelled',274.571376747262), (20,16,'2023-12-18','delivered',332.249991440716), (38,3,'2023-12-19','delivered',765.326113974775), (97,8,'2023-12-20','cancelled',764.982576944455), (12,19,'2023-12-21','cancelled',708.355084778791), (78,3,'2023-12-22','cancelled',478.759102163859), (92,19,'2023-12-23','cancelled',653.758547483492), (49,11,'2023-12-24','cancelled',302.246544820546), (56,11,'2023-12-25','delivered',363.997935677427), (2,9,'2023-12-26','delivered',850.249255793347), (34,5,'2023-12-27','delivered',119.649205797099), (26,2,'2023-12-28','delivered',816.33296474481), (46,14,'2023-12-29','delivered',615.673617840751), (45,19,'2023-12-30','cancelled',359.618169773367), (16,5,'2023-12-31','delivered',507.457765796236) ;

set @days = 90;

with last_n_days as (select distinct cust_id from order_fact where order_date between curdate() - interval @days day and curdate() )
select o.cust_id, max(o.order_date) `last order date`
from order_fact o
where not exists (select 1 from last_n_days l where l.cust_id=o.cust_id) 
group by o.cust_id 
order by 2 ;