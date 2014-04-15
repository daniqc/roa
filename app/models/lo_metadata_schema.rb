class LoMetadataSchema < ActiveRecord::Base
	belongs_to :learning_object
	belongs_to :metadata_schema

	attr_accessible :learning_object_id, :metadata_schema_id, :value


	def self.update_general_metadata(
		general_title_id, general_title,
		general_identifier_id, general_identifier,
		general_languages_id, general_languages,
		general_coverage_id, general_coverage,
		general_structure_id, general_structure,
		general_aggregation_level_id, general_aggregation_level,
		general_description_id, general_description,
		general_keywords_id, general_keywords)

		title = find(general_title_id)
		title.update_attributes(:value => general_title)

		identifier = find(general_identifier_id)
		identifier.update_attributes(:value => general_identifier)

		language = find(general_languages_id)
		language.update_attributes(:value => general_languages)

		coverage = find(general_coverage_id)
		coverage.update_attributes(:value => general_coverage)

		structure = find(general_structure_id)
		structure.update_attributes(:value => general_structure)

		aggregation_level = find(general_aggregation_level_id)
		aggregation_level.update_attributes(:value => general_aggregation_level)

		description = find(general_description_id)
		description.update_attributes(:value => general_description)

		keywords = find(general_keywords_id)
		keywords.update_attributes(:value => general_keywords)		
	end

	def self.update_life_cycle_metadata(
      life_cycle_version_id, life_cycle_version,
      life_cycle_status_id, life_cycle_status,
      life_cycle_contribute_role_id, life_cycle_contribute_role,
      life_cycle_contribute_entity_id, life_cycle_contribute_entity,
      life_cycle_contribute_date_id, life_cycle_contribute_date)

	  version = find(life_cycle_version_id)
	  version.update_attributes(:value => life_cycle_version)

	  status = find(life_cycle_status_id)
	  status.update_attributes(:value => life_cycle_status)

	  contribute_role = find(life_cycle_contribute_role_id)
	  contribute_role.update_attributes(:value => life_cycle_contribute_role)

	  contribute_entity = find(life_cycle_contribute_entity_id)
	  contribute_entity.update_attributes(:value => life_cycle_contribute_entity)

	  contribute_date = find(life_cycle_contribute_date_id)
	  contribute_date.update_attributes(:value => life_cycle_contribute_date)		
	end

	def self.update_educational_metadata(
      educational_interactivity_type_id, educational_interactivity_type,
      educational_learning_resource_types_id, educational_learning_resource_types,
      educational_interactivity_level_id, educational_interactivity_level,
      educational_semantic_density_id, educational_semantic_density,
      educational_intended_end_user_role_id, educational_intended_end_user_role,
      educational_context_id, educational_context,
      educational_typical_age_range_id, educational_typical_age_range,
      educational_difficulty_id, educational_difficulty,
      educational_typical_learning_time_id, educational_typical_learning_time,
      educational_description_id, educational_description,
      educational_language_id, educational_language)

	  interactivity_type = find(educational_interactivity_type_id)
	  interactivity_type.update_attributes(:value => educational_interactivity_type)

	  learning_resource_types = find(educational_learning_resource_types_id)
	  learning_resource_types.update_attributes(:value => educational_learning_resource_types)

	  interactivity_level = find(educational_interactivity_level_id)
	  interactivity_level.update_attributes(:value => educational_interactivity_level)

	  semantic_density = find(educational_semantic_density_id)
	  semantic_density.update_attributes(:value => educational_semantic_density)

	  intended_end_user_role = find(educational_intended_end_user_role_id)
	  intended_end_user_role.update_attributes(:value => educational_intended_end_user_role_id)

	  context = find(educational_context_id)
	  context.update_attributes(:value => educational_context)

	  typical_age_range = find(educational_typical_age_range_id)
	  typical_age_range.update_attributes(:value => educational_typical_age_range)

	  difficulty = find(educational_difficulty_id)
	  difficulty.update_attributes(:value => educational_difficulty)

	  typical_learning_time = find(educational_typical_learning_time_id)
	  typical_learning_time.update_attributes(:value => educational_typical_learning_time)

	  description = find(educational_description_id)
	  description.update_attributes(:value => educational_description)

	  language = find(educational_language_id)
	  language.update_attributes(:value => educational_language)
	end

	def self.update_rights_metadata(
      rights_cost_id, rights_cost,
      rights_copy_rights_and_other_restrictions_id, rights_copy_rights_and_other_restrictions,
      rights_description_id, rights_description)

      cost = find(rights_cost_id)
	  cost.update_attributes(:value => rights_cost)

	  copy_rights_and_other_restrictions = find(rights_copy_rights_and_other_restrictions_id)
	  copy_rights_and_other_restrictions.update_attributes(:value => rights_copy_rights_and_other_restrictions)

	  description = find(rights_description_id)
	  description.update_attributes(:value => rights_description)
	end
end
