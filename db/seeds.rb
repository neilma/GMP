# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



policy_symbols = %w(01A 01C 01D 01E 01R 02A 04D 04F 04V 05A 05B 05M 06A 06B 06C 06E 06F 06H 06J 06K 06L 06M 06S 06U 06V 06Y 07U 08A 09A 09C 09D 09F 10C 10F 10M 13A 14A 15C 15D 15E 15F 15I 15N 15R 15T 16A 17A 17E 17L 17M 17P 17U 17W 18A 21A 21C 21D 23A 23B 23C 23D 23L 23M 24B 24C 24F 24K 24M 24T 25A 32A 32F 32X 32Y 32Z 34A 35A 35B 35R 35S 35T 35U 39C 39P 40A)
policy_symbols.each { |policy_symbol| PolicySymbol.find_or_create_by(code: policy_symbol) }

policy_status = ["CURRENT", "LAPSED", "PREMIUM OWING", "CANCELLED"]
policy_status.each { |policy_status| PolicyStatus.find_or_create_by(status: policy_status) }

issue_states = { "71" => "ACT", "72" => "NSW", "95" => "NT", "73" => "VIC", "74" => "QLD", "75" => "SA", "76" => "WA", "77" => "TAS", "79" => "Head Office", "84" => "PNG", "86" => "Pacific Islands", "99" => "Other/Unknown" }
issue_states.each { |key, value| IssueState.find_or_create_by(state_id: key.to_i, state_code: value) }

type_bureaus = %w(AG AL BB BI BS BU CB CC CG CL CO CP CR CS CV CW EB EC ED EM EN ER FB FG FI FN FR FS GB GL GP GR GS HH HN IC IF IM IT LB LC LI LP LR LS MA MC MD MO MV NB PA PD PL PN TI TK TL TR WC WL WN)
type_bureaus.each { |type_bureau| TypeBureau.find_or_create_by(code: type_bureau) }
