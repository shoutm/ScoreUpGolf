class AddForeignKey < ActiveRecord::Migration
  def up
    execute "alter table competitions add constraint fk_competitions__golf_field_id foreign key (golf_field_id) references golf_fields(id)"
    execute "alter table competitions add constraint fk_competitions__firsthalf_cource_id foreign key (firsthalf_cource_id) references golf_cources(id)"
    execute "alter table competitions add constraint fk_competitions__secondhalf_cource_id foreign key (secondhalf_cource_id) references golf_cources(id)"
    execute "alter table golf_cources add constraint fk_golf_cources__golf_field_id foreign key (golf_field_id) references golf_fields(id)"

    execute "alter table golf_fields_greens add constraint fk_golf_fields_greens__golf_field_id foreign key (golf_field_id) references golf_fields(id)"
    execute "alter table golf_fields_greens add constraint fk_golf_fields_greens__green_id foreign key (green_id) references greens(id)"

    execute "alter table golf_holes add constraint fk_golf_holes__golf_cource_id foreign key (golf_cource_id) references golf_cources(id)"

    execute "alter table parties add constraint fk_parties__competition_id foreign key (competition_id) references competitions(id)"

    execute "alter table players add constraint fk_players__party_id foreign key (party_id) references parties(id)"
    execute "alter table players add constraint fk_players__user_id foreign key (user_id) references users(id)"

    execute "alter table shot_results add constraint fk_shot_results__player_id foreign key (player_id) references players(id)"
    execute "alter table shot_results add constraint fk_shot_results__golf_hole_id foreign key (golf_hole_id) references golf_holes(id)"
  end

  def down
    execute "alter table competitions drop foreign key fk_competitions__golf_field_id"
    execute "alter table competitions drop foreign key fk_competitions__firsthalf_cource_id"
    execute "alter table competitions drop foreign key fk_competitions__secondhalf_cource_id"
    execute "alter table golf_cources drop foreign key fk_golf_cources__golf_field_id"

    execute "alter table golf_fields_greens drop foreign key fk_golf_fields_greens__golf_field_id"
    execute "alter table golf_fields_greens drop foreign key fk_golf_fields_greens__green_id"

    execute "alter table golf_holes drop foreign key fk_golf_holes__golf_cource_id"

    execute "alter table parties drop foreign key fk_parties__competition_id"

    execute "alter table players drop foreign key fk_players__party_id"
    execute "alter table players drop foreign key fk_players__user_id"

    execute "alter table shot_results drop foreign key fk_shot_results__player_id"
    execute "alter table shot_results drop foreign key fk_shot_results__golf_hole_id"
  end
end
