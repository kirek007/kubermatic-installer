package util

import (
	"github.com/Masterminds/semver"
	"github.com/kubermatic/kubermatic-installer/pkg/yamled"
)

func UpdateVersion(doc *yamled.Document, path yamled.Path, version string) bool {
	currentVersion, exists := doc.GetString(path)
	if !exists {
		return false
	}

	v, err := semver.NewVersion(currentVersion)
	if err == nil {
		min, _ := semver.NewVersion(version)

		if v.LessThan(min) {
			doc.Set(path, version)

			return true
		}
	}

	return false
}