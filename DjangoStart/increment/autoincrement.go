package main

import (
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"sort"
	"strconv"
	"strings"
)

func main() {
	for {
		option := getVersionInput()

		var arg string
		switch option {
		case 1:
			arg = "major"
		case 2:
			arg = "minor"
		case 3:
			arg = "patch"
		default:
			fmt.Println("Invalid option. Please choose 1, 2, or 3.")
			continue
		}

		// Get the current highest semantic version
		output, err := exec.Command("docker", "images", "--format", "{{.Tag}}").Output()
		if err != nil {
			fmt.Println("Error executing docker command:", err)
			return
		}

		tagRegex := regexp.MustCompile(`^\d+\.\d+\.\d+$`)
		tags := tagRegex.FindAllString(string(output), -1)
		sort.Slice(tags, func(i, j int) bool {
			v1 := parseVersion(tags[i])
			v2 := parseVersion(tags[j])
			return compareVersions(v1, v2) > 0
		})

		var highestVersion string
		if len(tags) > 0 {
			highestVersion = tags[0]
		}

		var newVersion string
		if highestVersion == "" {
			// If no versions found, start with 1.0.0
			newVersion = "1.0.0"
		} else {
			// Split the current version into MAJOR, MINOR, and PATCH components
			versionParts := parseVersion(highestVersion)
			major, minor, patch := versionParts[0], versionParts[1], versionParts[2]

			// Increment the version based on semantic versioning rules
			switch arg {
			case "major":
				major++
				minor = 0
				patch = 0
			case "minor":
				minor++
				patch = 0
			case "patch":
				patch++
			default:
				fmt.Println("Invalid version type. Please provide 'major', 'minor', or 'patch' as an argument.")
				return
			}

			newVersion = fmt.Sprintf("%d.%d.%d", major, minor, patch)
		}

		// Build and tag the Docker image
		cmd := exec.Command("docker", "build", "-t", "your_image_name:"+newVersion, "../")
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		err = cmd.Run()
		if err != nil {
			fmt.Println("Error building Docker image:", err)
			return
		}
	}
}

// Helper function to parse version components into integers
func parseVersion(version string) []int {
	parts := strings.Split(version, ".")
	var versionParts []int
	for _, part := range parts {
		num, _ := strconv.Atoi(part)
		versionParts = append(versionParts, num)
	}
	return versionParts
}

// Helper function to compare two versions
func compareVersions(v1, v2 []int) int {
	for i := 0; i < len(v1); i++ {
		if v1[i] > v2[i] {
			return 1
		} else if v1[i] < v2[i] {
			return -1
		}
	}
	return 0
}

// Helper function to get user input for the version increment type
func getVersionInput() int {
	var option int
	for {
		fmt.Println("Please choose the version increment type:")
		fmt.Println("1. Major")
		fmt.Println("2. Minor")
		fmt.Println("3. Patch")
		fmt.Print("Enter the option number: ")
		_, err := fmt.Scanln(&option)
		if err != nil {
			fmt.Println("Invalid input. Please try again.")
			continue
		}
		if option >= 1 && option <= 3 {
			break
		}
		fmt.Println("Invalid option. Please choose 1, 2, or 3.")
	}

	return option
}
