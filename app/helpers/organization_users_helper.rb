module OrganizationUsersHelper
    def member_role_name
        if current_user.isLawFirm?
            return "attorney"
        elsif current_user.isInsuranceCompany?
            return "agent"
        end
    end
end
