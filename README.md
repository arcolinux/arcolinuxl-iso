<p align="center">
 <img src="https://github.com/erikdubois/arcolinux-nemesis/blob/master/Personal/settings/arcolinuxws.png">
</p>

## Project Update: Transition to New Repositories

## Repository Status: Deprecated

**IMPORTANT NOTICE**: As of April 2024, these GitHub repositories will no longer be maintained and are preserved solely as a reference for the numerous tutorial videos available on YouTube. For active development and ISO building guides, please visit our new repositories.

## Transition Announcement

In April 2024, we announced a significant shift in our project to enhance simplification and efficiency. This update is focused on streamlining deployment and testing processes to improve the overall user experience.

## Key Updates

### Consolidation of ISOs
- **Reduced Complexity**: We have streamlined from 45 different ISO images to just three, simplifying testing and maintenance.
- **Tailored Options**: The available ISOs are optimized for diverse user needs, incorporating boot systems like GRUB, systemd, and rEFInd.

### Calamares Installer Enhancements
- **Enhanced Integration**: The Calamares installer now seamlessly supports multiple bootloaders, including the new rEFInd option, alongside existing GRUB and systemd-boot.

### Desktop Environment and Software Selection
- **Optimized Choices**: We have phased out less stable or popular desktops and software, focusing on options that provide stability and are well-regarded within the community.

### Community Testing and Feedback
- **Engagement Request**: Community testing of the new ISOs is vital. We rely on your feedback to ensure compatibility across a wide range of hardware and to make necessary adjustments.

### Future Directions and Bootloaders
- **Innovation Continues**: We are exploring additional bootloaders and kernels to increase flexibility and meet the evolving preferences of our users.

### Commitment to Education and Updates
- **Rolling Release and Learning**: Our project remains committed to the rolling release model, promoting continual learning and regular updates to enhance skills in Linux and Arch-based distributions.

## Internet Connectivity and Kernel Testing
- **Increased Importance of Connectivity**: Test your internet connectivity with the following kernel options, based on your distribution choice:
  - **Arconet**: linux kernel, linux-zen kernel
  - **Arcopro**: linux kernel, linux-lts kernel
  - **Arcoplasma**: linux-kernel, linux-cachyos

## Guidance for Building ISOs
For detailed instructions on building your ISOs using the latest tools and best practices, refer to our new active repositories:

- **[Arconet Pro Repositories](https://github.com/orgs/arconetpro/repositories)**

## Just keep rolling

Users of ArcoLinuXL, ArcoLinuXS, ArcoLinuxD, and ArcoLinuxB ISOs can continue to enjoy the rolling release model, as these distributions are based on Arch Linux, which is inherently designed to roll forward with continuous updates.

**NOTE**: We use the `archiso` package from Arch Linux, which is subject to ongoing updates. Not every Arch Linux-based distro has access to this tool. Stay updated with the latest versions of `archiso` [here](https://www.archlinux.org/packages/extra/any/archiso/).

We appreciate your continued support and feedback as we transition to these new platforms and enhance our project.
