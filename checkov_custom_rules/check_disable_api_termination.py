from checkov.common.models.base import BaseCheck
from checkov.terraform.parsers import parse
from checkov.terraform.models import Block

class EC2DisableAPITermination(BaseCheck):
    def __init__(self):
        # Initialize with a unique Check ID and a description
        name = "Ensure EC2 instances have disable_api_termination set to true"
        id = "CKV_CUSTOM_1"  # Custom Check ID
        check_type = "terraform"
        # You can also include metadata if you want
        # e.g., tags, severity levels, etc.
        self.resource_type = "aws_instance"
        
        # Define the criteria for the check to pass
        # In this case, we want to ensure the API termination is disabled
        self.disabled = False

        super().__init__(name=name, id=id, check_type=check_type)

    def scan(self, resource: Block):
        """
        Scans an AWS EC2 instance to ensure `disable_api_termination` is set to `true`.
        """
        if "disable_api_termination" in resource.keys:
            # If the value of disable_api_termination is true, we pass
            if resource.get("disable_api_termination") == "true":
                return CheckResult.PASSED
            else:
                return CheckResult.FAILED
        return CheckResult.FAILED
