---------------------------RAPPI query de jesus ---------------------------------------------
with vinculados as (SELECT fl1.user_id, max(fl1.created_at)
                    FROM financials.link fl1
                    WHERE fl1.status in ('active')
                    GROUP BY fl1.user_id),
    desvinculados as (SELECT fl2.user_id, max(fl2.created_at)
                    FROM financials.link fl2
                    WHERE fl2.status in ('delete', 'deleted')
                    GROUP BY fl2.user_id),
    intento_vinculacion as (SELECT fla.user_id, case when fla.link_attempt_method like ('EFIRMA') then 'EFIRMA' else 'CIEC' end as metodo, max(fla.created_at) 
                    FROM financials.link_attempt fla
                    GROUP BY fla.user_id, metodo),
    carga_fiel as (SELECT ft.user_id, max(ft.created_at)
                    FROM financials.taxpayer_efirma ft
                    GROUP BY ft.user_id)
SELECT distinct hb.fcrfc rfc,
        ua.id user_id, 
        hb.fiinternalpartneridentifier,
        ua.first_name nombre, 
        ua.father_surname apellido, 
        ua.email email, 
        ua.cellphone celular, 
        case when vinculados.max is null and desvinculados.max is null 
                then 'No vinculado'
            when vinculados.max is null and desvinculados.max is not null 
                then 'Desvinculado'
            when vinculados.max is not null and desvinculados.max is null 
                then 'Vinculado'
            when vinculados.max is not null and desvinculados.max is not null and vinculados.max > desvinculados.max 
                then 'Vinculado'
            when vinculados.max is not null and desvinculados.max is not null and vinculados.max < desvinculados.max 
                then 'Desvinculado' end as vinculacion,
        vinculados.max ultima_vinculacion, 
        desvinculados.max ultima_desvinculacion,
        case when vinculados.max is null and desvinculados.max is null 
                then 'No vinculado'
            when vinculados.max is null and desvinculados.max is not null and desvinculados.max > '2024-03-14' 
                then 'Desvinculado en campaña'
            when vinculados.max is null and desvinculados.max is not null and desvinculados.max < '2024-03-14' 
                then 'Desvinculado antes de campaña'
            when vinculados.max is not null and desvinculados.max is null and vinculados.max > '2024-03-15' 
                then 'Vinculado en campaña'
            when vinculados.max is not null and desvinculados.max is null and vinculados.max < '2024-03-15' 
                then 'Vinculado antes de campaña'
            when vinculados.max is not null and desvinculados.max is not null and vinculados.max > desvinculados.max and vinculados.max > '2024-03-15' 
                then 'Vinculado en campaña'
            when vinculados.max is not null and desvinculados.max is not null and vinculados.max > desvinculados.max and vinculados.max < '2024-03-15' 
                then 'Vinculado antes de campaña'
            when vinculados.max is not null and desvinculados.max is not null and vinculados.max < desvinculados.max and desvinculados.max > '2024-03-15' 
                then 'Desvinculado en campaña'
            when vinculados.max is not null and desvinculados.max is not null and vinculados.max < desvinculados.max and desvinculados.max < '2024-03-15' 
                then 'Desvinculado antes de campaña' end as detalle,
        intento_vinculacion.metodo metodo_vinculacion,
        intento_vinculacion.max fecha_intento,
        carga_fiel.max fecha_cargue_fiel,
        case when ic.id is not null and ic.valid_to > now() 
                then 'Sellos creados y válidos'
                when  ic.id is not null and ic.valid_to < now() 
                then 'Sellos vencidos'
                    else 'Sellos no creados' end as estado_sellos,
        case when ic.id is not null and ic.valid_to > now() and ic.updated_at < '2024-03-14' 
                then 'Sellos creados previos a la campaña' 
            when  ic.id is not null and ic.valid_to > now() and ic.updated_at >= '2024-03-14' 
                then 'Sellos creados en campaña'
                    else 'Sellos por crear' end as detalle_sellos,
        case when ic.id is not null and ic.valid_to > now()  
                then max(ic.created_at)
                    else null end as fecha_sellos,
        case when ic.id is not null and ic.valid_to > now()  
                then ic.valid_to
                    else null end as fecha_validez_sellos
FROM heru_core_bussiness_process_service.businesspartnercontributor hb 
LEFT JOIN users.user_account ua ON ua.id = hb.fiuserid
LEFT JOIN carga_fiel ON carga_fiel.user_id = hb.fiuserid
LEFT JOIN invoicing.certificate ic ON ic.user_id = hb.fiuserid
LEFT JOIN vinculados ON vinculados.user_id = hb.fiuserid
LEFT JOIN desvinculados ON desvinculados.user_id = hb.fiuserid
LEFT JOIN intento_vinculacion ON intento_vinculacion.user_id = hb.fiuserid
WHERE ua.utm_campaign in ('seals_compliance_existing_users')
GROUP BY hb.fcrfc, ua.id,hb.fiinternalpartneridentifier,ua.first_name,ua.father_surname,ua.cellphone,ua.email,vinculados.max,desvinculados.max,intento_vinculacion.metodo,intento_vinculacion.max,carga_fiel.max,ic.id,ic.valid_to,ic.updated_at



------------------------ query Rappi cesar ----------------------------------





---------- Este query analiza el RFC en taxpayers, efirma y csd
with all_taxpayers as (
    select code,user_id,rank() over (partition by code order by created_at desc) as date_added
from financials.taxpayer
where user_id is not null)

,taxpayers as (select * from all_taxpayers where date_added = 1)

,combined_results as (
select 
t.code,
t.user_id,
te.created_at::text as fiel_added,
te.expiration_date::text as fiel_expiration_date,
te.email as fiel_email,
te.curp as fiel_curp,
c.created_at::date as csd_added,
c.valid_to::date as csd_expiration_date
from taxpayers t 
left join financials.taxpayer_efirma te on t.user_id=te.user_id 
left join invoicing.certificate c on t.user_id=c.user_id

union 

select 
code,
user_id,
'' as fiel_added,
'' as fiel_expiration_date,
'' as fiel_email,
'' as fiel_curp,
created_at::date as csd_added,
valid_to::date as csd_expiration_date
from invoicing.certificate
)

,deduplicated_results as (
    select *,
    row_number() over (partition by code 
                ORDER BY 
                (fiel_added IS NOT NULL AND fiel_added <> '') DESC,
                (fiel_expiration_date IS NOT NULL AND fiel_expiration_date <> '') DESC--,
                --(fiel_email IS NOT NULL AND fiel_email <> '') DESC,
                --(fiel_curp IS NOT NULL AND fiel_curp <> '') DESC,
                --(csd_added IS NOT NULL) DESC
        ) AS rn 
    -- (partition by code, user_id order by (fiel_added is not null and fiel_added <> '-') desc) as rn
    FROM combined_results
)

,rts_full_db as (select 
eo.fjinputdata ->> 'RFC' as rfc,
coalesce(bp.fiinternalpartneridentifier::text, (eo.fjinputdata ->>'SKID')) as skid,
AVG((eo.fjinputdata ->> 'MONTO_SIN_PROPINA')::numeric) as monto

from heru_core_bussiness_process_service.eventoperations eo
left join heru_core_bussiness_process_service.businesspartnercontributor bp on (eo.fjinputdata ->> 'RFC')::text=bp.fcrfc::text

where eo.fjinputdata ->> 'RFC' != '0'
and eo.fdcreatedat > date_trunc('month',eo.fdcreatedat) - interval '2 month'
group by 1,2
order by 1 desc) 

select 
code as rfc,
user_id,
first_name,
email,
cellphone,
fiel_added,
fiel_expiration_date,
csd_added,
csd_expiration_date,
fiel_email,
fiel_curp
from deduplicated_results dr
join users.user_account u on dr.user_id=u.id
where rn = 1 and dr.code in ({{filtro_rts}});




--------------
tax select payed
from fiscal.declaration_document




----------- query para el precalculo de las declraraciones----------


select dd.*
from fiscal.declaration d
left join fiscal.declaration_detail dd on d.id = dd.declaration_id
where month = '7'
and year = '2024'
order by declaration_id asc



-----------------------informacion de acuses-------------------------



---///con RFC
SELECT *
FROM fiscal.declaration_document_parsed_detail
where user_ in ('479421','477540','64584','41055','388667','72996','469477','456870','352400','471263','330386','68257','121205','481121','74072','448185','193884','84590','330072','70940','67678','317669','87879','131435','453082','10399','465601','115956','40618','45469','90620','376351','336799','183733','160296','334549','382240','106146','393481','393918','112373','96948','66436','336019','10399','477504','467721','468827','102201','451510','341380','413066','217275','363212','324325','453742','459552','101004','64947','89849','80806','431751','389796','66268','341755','53855','221898','61473','239285','192924','101888','52350','41925','43040','453731')
and fiscal.declaration_document_parsed_detail.month in ('07')
and fiscal.declaration_document_parsed_detail.year in ('2024')




-----------------------------MOdalidad----------------------------------------



select user_id,method,created_at::date as created_at 
from fiscal.user_declaration_method where user_id in ({{user_id}})

-------------------------------------------
-------------------------------------------
-------------------------------------------


SELECT 
user_id,
method_paymenth,
created_at
FROM "financials"."taxpayer_method_payment" 
 where user_id in ({{user_id}})

 ---------------------------------------------------MODALIDAD DE PAGO PARA USUARIOS------------------------------------------------------------

SELECT *
FROM financials.taxpayer_has_fiscal_obligation
WHERE description LIKE '%definitivo%';




    WITH taxpayer_filtered AS (
        SELECT id, code
        FROM financials.taxpayer
        ------WHERE code = 'CABR240201IE0'
    ),

    csd_status as (
        SELECT *
        FROM (
            SELECT *,
                ROW_NUMBER() OVER (PARTITION BY taxpayer_id ORDER BY created_at DESC) AS row_num
            FROM financials.taxpayer_status
            WHERE status = 'ACTIVO'
        ) AS ranked
        WHERE row_num = 1
        AND file_url IS not NULL
    ),

    modalidad as (
        SELECT *
        FROM financials.taxpayer_has_fiscal_obligation
        WHERE description LIKE '%definitivo%'
    
    )

    SELECT tx.taxpayer_id, tx.file_uuid, tx.file_url, l.*
    FROM (
        WITH links AS (
            SELECT
                user_id,
                created_at,
                last_modified,
                status,
                initialized,
                username,
                channel,
                CASE WHEN credential_id IS NOT NULL AND status = 'active' THEN 'Credentials in DB' ELSE 'No credentials in DB' END AS credentials,
                RANK() OVER (PARTITION BY user_id ORDER BY last_modified DESC) AS last_modification_rank
            FROM financials.link
            WHERE source_supports_institution_id = 30
            and status ='active'
        )
        SELECT *
        FROM links
        WHERE last_modification_rank = 1
       ------and username = 'GOBI951010US7'
    ) l


    JOIN (
        SELECT id, code
        FROM taxpayer_filtered
    ) tf
    ON l.username = tf.code

    JOIN (
        SELECT id, taxpayer_id, file_url, file_uuid
        FROM csd_status
    ) tx
    ON tf.id = tx.taxpayer_id

    JOIN (
        SELECT id, description
        from modalidad
    ) md

    ON tf.id = md.id

    ORDER BY l.last_modified DESC;



select*
from fiscal.user_declaration_method


WIth(SELECT *
FROM financials.taxpayer_has_fiscal_obligation
WHERE description LIKE '%definitivo%';)



--------------buscar usuarios para facturas y deducibles ---------------


SELECT *
FROM temporal_registry.based_income
WHERE user_id = '61359' AND month = 08;


SELECT user_id, SUM(income_amount) AS total_income
FROM based_income
GROUP BY user_id;= '61359' 


SELECT *
FROM based_deductibles
WHERE
    user_id = 5727 
    and fft_id= 2957;

SELECT *
from crawling
WHERE
    user_id = '19887'
    and "type" = 'TAX_COMPLIANCE';



SELECT STATUS FROM FFT WHERE PERIOD = '2024-9';


UPDATE fft SET STATUS = 'IN_PROGRESS' WHERE PERIOD = '2024-9'; 
