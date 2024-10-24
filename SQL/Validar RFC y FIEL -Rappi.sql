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
--code 
--in (select distinct fjinputdata ->>'RFC' from heru_core_bussiness_process_service.eventoperations); -- (select rfc from rts_full_db);

select * from plans.user_renewal_flow_log order by created_at

select distinct fjinputdata ->>'RFC' from heru_core_bussiness_process_service.eventoperations;

select 
eo.fjinputdata ->> 'RFC' as rfc,
--coalesce(bp.fiinternalpartneridentifier::text, (eo.fjinputdata ->>'SKID')) as skid,
eo.fjinputdata ->>'SKID' as skid,
case when eo.fjinputdata ->> 'RFC' = '0' then 'Penalizado'
        when (eo.fjinputdata ->> 'RFC' = eo.fjinputdata ->>'SKID') 
                or eo.fjinputdata ->>'SKID' is null then 'Backfill SKID'
                    else null end as cluster,
AVG((eo.fjinputdata ->> 'MONTO_SIN_PROPINA')::numeric) as monto

from heru_core_bussiness_process_service.eventoperations eo
--left join heru_core_bussiness_process_service.businesspartnercontributor bp on (eo.fjinputdata ->> 'RFC')::text=bp.fcrfc::text

where --eo.fjinputdata ->> 'RFC' != 'ZATA7205285I1'
eo.fdcreatedat > date_trunc('month',eo.fdcreatedat) - interval '2 month'
group by 1,2,3
order by 1 desc;

select 
distinct eo.fjinputdata ->> 'RFC' as rfc,
eo.fjinputdata ->>'SKID' as skid

from heru_core_bussiness_process_service.eventoperations eo
where LENGTH(eo.fjinputdata ->>'SKID') < 13;

with cert_rappi_data as (select 
original_data ->>'RFC' as rfc,
original_data ->>'SKID' as skid,
rank() over (partition by original_data ->>'RFC' order by created_at desc) as cert_rank
from certificate_integrator.certification_registry

where LENGTH(original_data ->>'RFC') = 13)

select * from cert_rappi_data where cert_rank = 1; 