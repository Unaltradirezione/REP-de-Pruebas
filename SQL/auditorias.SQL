--------- Descargar las contraseñas del RFC para agilizar el proceso de busqueda -----

WITH RankedCrawl AS (
    SELECT
        user_id, 
        month, 
        year,
        status,
        REPLACE(input -> 'data' -> 'credentials' ->> 'username', '"', '') as rfc,
        REPLACE(input -> 'data' -> 'credentials' ->> 'password', '"', '') as password,
        created_at,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at DESC) as row_num
    FROM crawl_manager.crawl_task
    WHERE type in ('PLATEC_REGULARIZATION', 'PLATEC_DECLARATION') 
        AND created_at >= '2023-12-01' 
        --AND month = 10 
        --AND year = 2023
        AND user_id IN ('201169')
)
SELECT *
FROM RankedCrawl
WHERE row_num = 1;





--------- Descargar la información de los acuses presentados -----

---///con ID

SELECT *
FROM fiscal.declaration_document_parsed_detail
INNER JOIN  fiscal.declaration_document ON fiscal.declaration_document_parsed_detail.id = fiscal.declaration_document.id
where user_id in
('154986')
and fiscal.declaration_document_parsed_detail.month in ('08')
and fiscal.declaration_document_parsed_detail.year in ('2024')


SELECT *
FROM fiscal.declaration_document_parsed_detail
INNER JOIN  fiscal.declaration_document ON fiscal.declaration_document_parsed_detail.id = fiscal.declaration_document.id
where user_id in
('154986')
-----and fiscal.declaration_document_parsed_detail.month in ('08')
and fiscal.declaration_document_parsed_detail.year in ('2024')



---///con RFC
SELECT *
FROM fiscal.declaration_document_parsed_detail
where rfc in ('VECC8212311M3','CAYL950804B86','LESL721125IZ3','GAMA561006LB1','BATL940222H98','MACA590805NG0','MAGG580414DG1','TEAM780224R82','MAZG901003P12','BAMR6305272K2','MOAE7608228E2','BASD010803V12','KUCW710201767','VIPG980123259','MARA050531727','BADG830716GU4','COGX87083128A','BOGR690815SQ4','COCA0507107L9','MEEL9906079P8','GAAM8802187N3','GUAV881008U17','SAEA790725948','HEBE980912E33','PADA860114ES9','SAVM640204H84','BERN011118LK2','KOYI9005172XA','MAGA580717518','AABI800101SD2','BECI8804297Q9','EELB760813BV4','EIOL740306R58','CARJ010620TUA','VICA670530S13','DUMM701220M64','CUGL970626FZ5','MOCJ750214U15','RECH8305249L1','OINJ670708P75','COMH900529IE4','ZAAZ050428QJ4','ROMO920815DA1','GACA701216SR0','MEME880709MJ1','MERM701117SA1','SENA901016QC2','PEHF680808N52','MOAJ5705246A8','TEBD6312227H0','AUDP730628LE5','MAVM760119TA8','CAMM730907EU1','REGA930623LN9','FOAP9601151X4','PAJM670814HM5','MOBM700202AA7','AADA720803RV1','CUBM900823UW9','PEPH960509QA7','DUOE790203JD1','MUVI6406263Y5','OIPR880207FW3','PEPJ840713MD6','SOHR720409JE7','CAGW711118JVA','PAVH650110LG8','RARL8707109M6','SOFV7207217K6','MOCH731218CS8','FUPJ8406259Q4','PAEJ690713S8A','VAMH930310HKA','GAPU9005156V2','VIRE0111205C5','READ751226CR3','PEIF8112091L0','COSJ8202273G0','GAFA741210H23','GANJ7911149S9','AAAD900703V72','GAMJ960922MZ1','GOZJ9706087E5','EOCL8312229B6','MAOB780319F44','AARA0008229LA','MAPM920915CK2','BARA8311122R3','PAAJ821211L76','NURM920514RQ0','AAPA660408PVA','PICH671225A27','RORB0011057Z2','PAAC750724MU3','OEVS890223NQ5','DOPJ8906272VA','YUMM760108AI3','LURD950920MN6','RACA7912042Z4','RAPD810217JY3','GOED880322SY1','PAGA8312072T3','BARO0201234YA','LARO610220LX0','CUGS811127U38','VAHL790908362','FAAE821116PG9','GATA730418N63','CANJ041223UI3','TAEJ920728NB7','AAPM660209457','LUJF880309ED3','PEMG660502334','AORC970211UG3','VIBV7202062A7','LIJC901007ISA','NUCJ900912712','RASE740813237','VICR891217M54','NALJ7311047K6','COEG741014ND2','RACI690126K52','PUGC8308239W0','VEGC801107B24','MAZS740623PZ2','MAGA741009PB4','VISO000512J83','PECC930510195','PAIO890304FN2','LOLJ890528IG2','PEMJ931025PZ2','SOML750830U5A','CARG640212V65','CANR940624324','MATS890917SL0','ROVE730506DE0','GAGA000504GG7','VAOF781203B46','MOTJ740808QN0','PEHZ8810268L2','MEPH870418A55','MEMA550706FB9','GAVR8811129L8','HECP830625BJ9','RONA950315L34','DEBE960830A56','AAOR911129IS2','ZAVG901202K83','ROBO790924TM2','GARJ910605CD1','CACD740329UC0','LUML900715E94','VAEE710706R99','CUDF9702274A5','NALE981015SF5','ROMM720604F74','VEMJ9706043D3','GOAA710215KS2','MORL740720QR9','BAMM801114BZA','NIMA700412BG1','CACR850314LY7','TEBA580212IV3','SUBJ910422DL4','VASA670827E22','FERA780515896','SOCD890407467','MADM930902964','CACJ8707068W9','BILS671223NW0','MEFC991021IK5','RORS710712M5A','MOML800824M20','DEMD850204F83','VAMO760618EA2','SARF760804IS1','CALS871206442','MOCC850918RS5','RELM650324UN5','PEFB770417CN6','FIJE740714146','GOMJ9209035V6','SACL830621KA2','HILR720720E87','HECG720324S78','DIMR9608188T5','UIAJ840813MM1','COPE920701QN3','SAAR6801072I8','HEVL991206EBA','GURE780813IL4','CUMK000910MG6','QURW931029GC4','AEMJ690519IK2','FEAV950131SY4','GOMJ970319JT1','HEPJ851205KJ8','HEGG910926DG6')
and fiscal.declaration_document_parsed_detail.month in ('08')
and fiscal.declaration_document_parsed_detail.year in ('2024')



 ----Hacer el join con number.operation



select * 
from crawl_manager.crawl_task 
where created_at > date_trunc('month',now())
and user_id in
('1141','2496','5874','10252','12044','18425','19388','19800','27180','28507','29420','29426','30666','31680','33558','33887','36614','37959','38461','38542','39880','40673','41655','42111','43899','45363','47259','47425','47901','48431','50573','51279','53339','53590','55042','57897','58061','59596','61092','62081','62608','63280','63953','64871','65007','65180','66537','67761','69061','70439','71888','72995','74856','77424','79129','81737','86125','86843','87615','89927','91563','91612','93063','93508','94988','95462','96171','96471','98124','100390','100576','101004','101441','101845','105420','106440','106660','108542','108963','110962','111135','114418','121641','123119','131539','138448','139914','141186','142144','143052','151965','152321','155494','161213','167270','167687','167836','167885','173147','173392','175484','181632','185144','194013','200392','202360','203848','211390','215969','222738','226202','230121','239720','243609','251847','255555','260365','260529','268869','272485','278046','282697','289787','297210','297280','305456','308342','308383','312262','312523','313195','315547','315755','316984','317565','317675','317940','320783','323075','324991','325998','326850','330258','332190','333221','333313','333935','334199','335243','336024','336685','338585','338683')


--- /// Encontrar el RFC por medio del user ID ---

select
user_id,
username
from financials.link
Where
user_id in ('298434','290940','78403','78403','363232','363281','363281','41449','41449','195829','195829','195829','195829','195829','302241','334297','334190','86970','29577','29577','29577','145096','145096','342156','318418','47970','230393','254617','254617','254617','254617','115568','121125','121125','161270','161270','161270','161270','362875','362875','357547','357547','357547','357547','357547','357547','357547','28635','28635','28635','363060','63777','63777','349976','307679','307679','307679','44893','208550','208550','208550','242551','304301','349121','165754','52031','351485','46579','66451','301351','318784','172590','50586','340179','63418','347786','349692','344279','330439','66268','214554','352642','105082','110969','63214','190727','47970','142081','182519','346398','352128','65363','169056','352128','277849','96278','66427','72847','231100','116532','72806','61390','13405','95733','354167','48012','96278','110969','106268','345590','59592','32922','110025','29667','190714','242643','278333','352128','81229','191853','268612','13405','177401','162976','150592','61418','268259','104137','115950','155305','72847','110969','181277','95733','32922','63509','61831','82691','232539','106268','344999','345897','53718','337277','106268','84239','268841','320467','47970','45808','87443','47569','339664','345590','713','45808','347260','110969','112193','63214','334609','106268','352128','191899','318922','311500','49014','82451','64436','25991','129458')


------/// DEFINE regularización Normal o Completaria y la plataforma --------------

WITH DeclarationData AS (
    SELECT
        fd.user_id,
        fd.month,
        fd.year,
        declaration_type,
        STRING_AGG(issuer_name, ', ') AS issuer_names
    FROM
        fiscal.declaration_document AS fd
    JOIN
        financials.income AS fi ON fd.user_id = fi.user_id
    WHERE
        fd.user_id || '-' || fd.month || '-' || fd.year IN ('47736','452466','50497','345941','472399','463395','142538','285064','456058','43018','245121','236045','72338','453910','180619','163614','418478','409970','453543','448539','46064','112408','467189','46306','111976','114713','59281','316274','264721','53930','20678','94702','32365','144183','96871','466420','106153','71323')
    GROUP BY
        fd.user_id,
        fd.month,
        fd.year,
        declaration_type
)


------------------------TEMPORAL PARA MODALIDAD EN VALIDACIÓN --------------------------------


with tax_status as (select 
        s.taxpayer_id,
        s.status as csf_tax_status,
        s.id,
        s.created_at,
        user_id,
        file_uuid,
        'https://d1tczejhd1bvnt.cloudfront.net/'||file_path as csf_file,
        rank() over (partition by taxpayer_id order by s.created_at desc) status_rank
        from financials.taxpayer_status s
        join financials.taxpayer t on s.taxpayer_id=t.id
        left join file.file_info fi on s.file_uuid=fi.uuid
        where t.user_id in ('28635')
        group by 1,2,3,4,5,6,7)

,modality as (select 
taxpayer_status_id,
user_id,
csf_tax_status,
ts.created_at::date as csf_created_at,
csf_file,
array_agg(description)::text as obligations
from tax_status ts 
join financials.taxpayer_has_fiscal_obligation tos on ts.id=tos.taxpayer_status_id
where status_rank = 1
group by 1,2,3,4,5)

select
u.id,
initcap(csf_tax_status) as csf_tax_status,
csf_created_at,
csf_file,
case when obligations ilike '%definitivo%' then 'Definitivo'
                when obligations ilike '%provisional%' then 'Provisional'
                else 'Review' end as payment_modality,
initcap(l.status) as link_status,
last_modified as link_date

from users.user_account u
left join modality lt on u.id=lt.user_id
left join (
    select 
    user_id,
    status,
    last_modified,
    rank() over (partition by user_id order by last_modified desc) as link_update
    from financials.link) as l on u.id=l.user_id and link_update = 1

where u.id in ('28635');



--------------------// PARA BUSCAR LAS PLATAFORMAS PARA LAS QUE TRABAJA UN USUARIO--------------


SELECT
    user_id,
    STRING_AGG(DISTINCT issuer_name, ', ') AS plataformas
FROM
    financials.income
WHERE
    user_id IN ('301667','45569','64105','314831','71737','72919','318922','316933','218887','61835','449789','107890','51679','357435','64999','109490','101664','52238','362464','43712','217082','280133','211897','477423','63937','104826','75669','94988','324604','36713','45638','75648','469131','182901','58036','56899','387007','347863','108814','29261','353898','80690','48352','68286','448706','52007','261472','30084','106122','232182','456655','80177','160712','64542','116539','278760','190851','316875','440796','67435','78608','98022','44292','78309','59070','90435','109501','459552','90468','48320','325747','105559','453631','321217','84029','101004','296264','52842','454064','167357','155625','30757','66928','317104','281542','73089','29950','457104','81840','56086','454065','38308','242927','317740','80910','101474','182244','61917','149614','467663','74838','96171','452146','183541','358790','248518','241336','317226','55986','69077','46864','136416','80139','63554','156295','54917','54910','33000','43748','205651','52104','53718','42506','52350','319436','74617','193476','48852','224807','6392','33881','86990','79989','463865','103476')
    AND period >= '2024-01-01'
GROUP BY
    user_id;



------------------------------//PARA ENCONTRAR EL RÉGIMEN

SELECT
    t.*,
    tr.*
FROM
    financials.taxpayer t
JOIN
    financials.taxpayer_has_tax_regime tr
ON
    t.id = tr.taxpayer_status_id
WHERE
    t.user_id in ('301667','45569','64105','314831','71737','72919','318922','316933','218887','61835','449789','107890','51679','357435','64999','109490','101664','52238','362464','43712','217082','280133','211897','477423','63937','104826','75669','94988','324604','36713','45638','75648','469131','182901','58036','56899','387007','347863','108814','29261','353898','80690','48352','68286','448706','52007','261472','30084','106122','232182','456655','80177','160712','64542','116539','278760','190851','316875','440796','67435','78608','98022','44292','78309','59070','90435','109501','459552','90468','48320','325747','105559','453631','321217','84029','101004','296264','52842','454064','167357','155625','30757','66928','317104','281542','73089','29950','457104','81840','56086','454065','38308','242927','317740','80910','101474','182244','61917','149614','467663','74838','96171','452146','183541','358790','248518','241336','317226','55986','69077','46864','136416','80139','63554','156295','54917','54910','33000','43748','205651','52104','53718','42506','52350','319436','74617','193476','48852','224807','6392','33881','86990','79989','463865','103476');






-----------------Busacar RFC con ID----------------------




SELECT
CODE 
FROM 
FINANCIALS.TAXPAYER
WHERE USER_ID IN ('296264','101004','84029','321217','453631','105559','325747','48320','90468','459552','109501','90435','59070','78309','44292','98022','78608','67435','440796','316875','190851','278760','116539','64542','160712','80177','456655','232182','106122','30084','261472','52007','448706','68286','48352','80690','353898','29261','108814','347863','387007','56899','58036','182901','469131','75648','45638','36713','324604','94988','75669','104826','63937','477423','211897','280133','217082','43712','362464','52238','101664','109490','64999','357435','51679','107890','449789','61835','218887','316933','318922','72919','71737','314831','64105','45569','301667')





-------------------------------------------------//// DECLARACIONES COMPLETADAS ////---------------------------------------------

    with last_taxs as(
        select
            taxpayer_id,
            status as csf_tax_status,
            id,
            created_at,
            rank() over (partition by taxpayer_id order by created_at desc) status_rank
            from financials.taxpayer_status
            group by 1,2,3,4
    )

    ,regimes as (
        select
        taxpayer_id,
        array_to_string(array_agg(name), ',') as regimes
        from financials.taxpayer_has_tax_regime r
        left join last_taxs lt on r.taxpayer_status_id=lt.id
        group by 1
    ) 

    select 
    now()::date as sourced_at, 
    s.id as service_id,
    u.id as user_id,
    initcap(coalesce(case when t.name != '' then t.name else null end::varchar,u.first_name||' '||u.father_surname,u.first_name)) as customer_name,
    u.cellphone,
    u.email,
    t.code as rfc,
    p.name as product_name,
    case when p.id in (31,32,41,42,43,44,45,24,25,26,27,123)
            then 'Declaración Anual'
                when p.id in (28,34) then 'ASAT'
                    when p.id in (86,111) then 'RIF declaration'
                        else 'Declaración mensual' end as service_type,
    case when product_version_id = 130 and s.created_at <= '2024-05-15' then '2023'
            when p.id in (31,32,41,42,43,44,45,24,25,26,27) then (s.product -> 'additional_information' ->> 'year')::varchar
                when p.id in (86,111) then (s.product -> 'additional_information' ->> 'period')::varchar||'-'||(s.product -> 'additional_information' ->> 'year')::varchar
                    else (s.product -> 'additional_information' ->> 'month')::varchar||'-'||(s.product -> 'additional_information' ->> 'year')::varchar end as period,
    ss.name,
    s.product,
    tr.created_at::date as transaction_date,
    sc.source_channel,
    tr.seller_id,
    initcap(coalesce(u2.first_name||' '||u2.father_surname,u2.first_name)) as seller,
    case when p.id in (31,43,44,45) then 'Annual with regularization'
        when p.id in (32,41,42,24,25,26,27,123) then 'Annual without regularization'
        when p.id = 28 then 'ASAT plus covered'
        when p.id = 34 then 'ASAT basic covered'
        when p.id = 89 then 'Heru Plus, all covered'
        when p.id in (118,119,102,103,71,75) then 'RESICO covered'
        when p.id in (112,121) then 'IF Actividad empresarial'
        when p.id in (104,105,79,83) then 'IF Arrendamiento'
        when p.id in (93) then 'IF arrendamiento and tech platform covered'
        when p.id in (111,86) then 'RIF'
        else 'Tech platorm covered' end as service_coverage,
    r.regimes,
    case when regimes ilike '%Régimen de las Actividades Empresariales con ingresos a través de Plataformas Tecnológicas%' then 'Tech regime' else 'Others' end as tech_regime

    from service_status.service s
    left join service_status.service_has_step st on s.current_service_has_step_id=st.id
    left join service_status.stage ss on st.stage_id=ss.id
    left join plans.product_version pv on s.product_version_id=pv.id
    left join plans.product p on pv.product_id=p.id
    left join financials.taxpayer t on s.user_id=t.user_id
    left join users.user_account u on s.user_id=u.id
    left join plans.shopping_cart sc on s.shopping_cart_id=sc.id
    left join payments_v2.transaction tr on sc.transaction_id=tr.id
    left join users.user_account u2 on tr.seller_id=u2.id
    left join regimes r on t.id=r.taxpayer_id

    where 
    st.step_id = 11
    AND s.completed_at >= '2024-07-10'
    ---and p.name = 'Plataformas tecnológicas'
    order by s.created_at desc;


    select completed_at
    from service_status.service_has_step