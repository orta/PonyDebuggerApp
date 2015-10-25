use_frameworks!

# not needed so far
# target 'PonyDebugger' do
# end

target 'EmptyiOSTarget' do
  platform :ios, '8.0'

  pod "PonyDebugger"
end

# As a key part of this app is embedding a Framework
# we do this by creating a Copy Phase in the `EmptyiOSTarget`
# that moves the migrated frameworks into a common file.

post_install do  |installer|
  require 'xcodeproj'

  project = installer.pods_project
  main_target = project.targets.find { |t| t.name == "Pods-EmptyiOSTarget" }

  #  Make a copy files phase to migrate the build frameworks somewhere reachable
  phase = main_target.new_copy_files_build_phase("Frameworks Copy Migration")
  phase.dst_subfolder_spec = Xcodeproj::Constants::COPY_FILES_BUILD_PHASE_DESTINATIONS[:absolute_path]
  phase.dst_path = "$(SRCROOT)/../frameworks"

  project.targets.each do |t|
    phase.add_file_reference t.product_reference if t != main_target
  end

  project.save()
end
