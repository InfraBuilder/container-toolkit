.PHONY: bump-major bump-minor bump-patch bump-date git-push help

# Get the latest git tag and its version components
CURRENT_VERSION=$(shell git describe --tags --abbrev=0)
MAJOR=$(shell echo $(CURRENT_VERSION) | cut -d. -f1)
MINOR=$(shell echo $(CURRENT_VERSION) | cut -d. -f2)
PATCH=$(shell echo $(CURRENT_VERSION) | cut -d. -f3)
NEW_DATE=$(shell date "+%y%m%d%H%M%S")

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  bump-major: Bump the major version"
	@echo "  bump-minor: Bump the minor version"
	@echo "  bump-patch: Bump the patch version"
	@echo "  bump-date: Bump the date"
	@echo "  git-push: Push the current branch and tags"
	@echo "  help: Show this help"

# Version bumping
bump-major:
	$(eval NEW_MAJOR=$(shell echo $$(( $(MAJOR) + 1 )) ))
	@echo "Bumping major version..."
	git tag -a $(NEW_MAJOR).0.0-$(NEW_DATE) -m "Bump major version to $(NEW_MAJOR).0.0"
	@echo To push this tag execute : 
	@echo git push origin $(NEW_MAJOR).0.0

bump-minor:
	$(eval NEW_MINOR=$(shell echo $$(( $(MINOR) + 1 )) ))
	@echo "Bumping minor version..."
	git tag -a $(MAJOR).$(NEW_MINOR).0-$(NEW_DATE) -m "Bump minor version to $(MAJOR).$(NEW_MINOR).0"
	@echo To push this tag execute : 
	@echo git push origin $(MAJOR).$(NEW_MINOR).0

bump-patch:
	$(eval NEW_PATCH=$(shell echo $$(( $(PATCH) + 1 )) ))
	@echo "Bumping patch version..."
	git tag -a $(MAJOR).$(MINOR).$(NEW_PATCH)-$(NEW_DATE) -m "Bump patch version to $(MAJOR).$(MINOR).$(NEW_PATCH)"
	@echo To push this tag execute : 
	@echo git push origin $(MAJOR).$(MINOR).$(NEW_PATCH)

bump-date:
	@echo "Bumping date version..."
	git tag -a $(MAJOR).$(MINOR).$(PATCH)-$(NEW_DATE) -m "Bump patch version to $(MAJOR).$(MINOR).$(NEW_PATCH)"

git-push:
	git push && git push --tags
