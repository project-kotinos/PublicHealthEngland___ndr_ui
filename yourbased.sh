build_targets:
- commands:
  - chmod +x yourbased.sh
  - sh ./yourbased.sh
  container:
    image: yourbase/yb_ubuntu:16.04
  environment:
  - BUNDLE_GEMFILE=gemfiles/Gemfile.rails52
  name: 2.6_Gemfile.rails52
- commands:
  - chmod +x yourbased.sh
  - sh ./yourbased.sh
  container:
    image: yourbase/yb_ubuntu:16.04
  environment:
  - BUNDLE_GEMFILE=gemfiles/Gemfile.rails60
  name: 2.6_Gemfile.rails60
ci:
  builds:
  - build_target: 2.6_Gemfile.rails52
    name: 2.6_Gemfile.rails52
  - build_target: 2.6_Gemfile.rails60
    name: 2.6_Gemfile.rails60
dependencies:
  build:
  - ruby:2.6
