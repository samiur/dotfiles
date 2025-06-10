PACKAGES := claude env spacemacs tmux zsh

.PHONY: $(PACKAGES)
all: $(PACKAGES)

.SECONDEXPANSION:

$(PACKAGES): %: $$(shell find $$*)
	stow -t ~ $*
