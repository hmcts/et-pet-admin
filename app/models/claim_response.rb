class ClaimResponse < ApplicationRecord
  self.table_name = :claims
  default_scope -> do
    select('"claims"."id" AS "claim_id", "responses"."id" AS "response_id"')
      .joins(
        <<-SQL
        INNER JOIN "exports" ON "exports"."resource_type"='Claim' AND "exports"."resource_id"="claims"."id" 
        INNER JOIN "external_systems" ON "external_systems"."id" = "exports"."external_system_id" 
          AND "external_systems"."reference" LIKE 'ccd%'
        INNER JOIN "responses" ON "exports"."external_data" ::json->>'case_reference' = "responses"."case_number"
        SQL
      )
  end
end