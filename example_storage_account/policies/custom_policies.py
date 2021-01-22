import re

from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class ResourceGroupPrefix(BaseResourceCheck):
    def __init__(self):
        super().__init__(
            name="Ensure resource group is prefixed by the environment name",
            id="MYORG_RG_001",
            categories=[CheckCategories.CONVENTION],
            supported_resources=["azurerm_resource_group"],
        )

    def scan_resource_conf(self, conf, entity_type):
        name = conf["name"][0]
        result = re.match("^(dev|prod)-", name)
        if result is None:
            return CheckResult.FAILED
        else:
            return CheckResult.PASSED


scanner = ResourceGroupPrefix()
