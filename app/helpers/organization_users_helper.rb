module OrganizationUsersHelper
    def member_role_name
        if current_user.isLawFirm?
            return "attorney"
        elsif current_user.isInsuranceCompany?
            return "agent"
        end
    end

    def organization_role_name
        if current_user.isAttorney?
            return "law firm"
        elsif current_user.isInsuranceAgent?
            return "insurance company"
        end
    end
end
