package com.ada.common;

/**
 * Created by Admin on 1/4/2018.
 */
public class Constants {

    //Danh sách biểu thức bất quy tắc
    public static final String REGEX_NUMBER = "^[0-9]*$";
    public static final String REGEX_SEARCH_NUMBER = "^[0-9*]*$";
    public static final String REGEX_TEXT_NUMBER = "^[a-zA-Z0-9]+$";
    public static final String REGEX_TEXT_USERNAME = "^[_a-zA-Z0-9]+$";
    public static final String REGEX_DATE = "^(?:(?:31(\\/|-|\\.)(?:0?[13578]|1[02]|(?:Jan|Mar|May|Jul|Aug|Oct|Dec)))\\1|(?:(?:29|30)(\\/|-|\\.)(?:0?[1,3-9]|1[0-2]|(?:Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$|^(?:29(\\/|-|\\.)(?:0?2|(?:Feb))\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\\d|2[0-8])(\\/|-|\\.)(?:(?:0?[1-9]|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep))|(?:1[0-2]|(?:Oct|Nov|Dec)))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$";
    public static final String REGEX_EMAIL = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
    public static final int LENGTH_RANDOM_CODE = 6;

    public static final String STATUS_STR_THANH_TOAN_HOAN_TAT = "HOÀN TẤT";
    public static final String STATUS_STR_THANH_TOAN_DANG_XU_LY = "ĐANG XỬ LÝ";
    public static final String STATUS_STR_THANH_TOAN_TU_CHOI = "TỪ CHỐI";

    public static final String PASSWORD_DEFAULT = "12345678";

    public class Log { //Log hệ thống

        public static final String system = "SYSTEM";
        public static final String user = "USER";
        public static final String category = "CATEGORY";
    }

    //status partner
    public static class CUSTOMER_STATUS {
        public static final Long DANG_HOAT_DONG = 1L;
        public static final Long NGUNG_HOAT_DONG = 2L;
    }

    //status config contract
    public static class STATUS_CONFIG_CONTRACT {
        //xoa boi osp admin
        public static final int DELETEBYOSP = 2;
    }

    //file name
    public static class FILE_NAME {
        //cmndmt
        public static final String INDENTITY_FRONT = "Cmndmt_%s";
        public static final String INDENTITY_BACK = "Cmndms_%s";
    }

    public static class STATUS {

        public static final int ACTIVE = 1;
        public static final int INACTIVE = 0;
        public static final int BLOCK = 2;
        public static final int PENDING = 3;
    }

    // yêu cầu thanh toán
    public static class REQUEST_STATUS {

        public static final Long TU_CHOI = 0L;
        public static final Long CHO_DUYET = 1L;
        public static final Long DA_DUYET = 2L;
        public static final Long DANG_XU_LY = 3L;
    }

    public static final String SYS_FEE_PAYMENT_KEY = "SYS_FEE_PAYMENT";

    //Loại tài khoản
    public static class FEE_PAYMENT {

        public static final String FREE = "0";
        public static final String PAY = "1";
    }

    public static class SOURCE_REQUEST {

        public static final Long ADMIN = 0L;
        public static final Long CTV = 1L;
    }

    // Trạng thái thanh toán
    public static class TYPE_PAYMENT {

        public static final Long TU_CHOI = 0L;
        public static final Long CHO_XY_LY = 1L;
        public static final Long DA_DUYET = 2L;
        public static final Long DANG_XU_LY = 3L;
    }

    // generate tên yêu cầu thanh toán
    public static class CONFIG_NAME {
        public static final String YC = "YC";
    }

    public static class ACTION_LOGS {

        public static final String THEM = "Thêm mới";
        public static final String SUA = "Sửa";
        public static final String XOA = "Xóa";
        public static final String XAC_NHAN_THAY_DOI_HOA_HONG = "5";
    }

    public static class SOURCE_LOGS {

        public static final String SIM_SO = "SIM_SO";
        public static final String YEU_CAU_THANH_TOAN = "YEU_CAU_THANH_TOAN";
        public static final String THANH_TOAN = "THANH_TOAN";
        public static final String GOI_CUOC = "GOI_CUOC";
        public static final String DOI_SOAT = "DOI_SOAT";
        public static final String CHANGE_ACC_BALANCE = "CHANGE_ACC_BALANCE";
    }

    // Loại file
    public static class TYPE_FILE {

        public static final Long TIN_TUC = 1L;
        public static final Long DUYET_YEU_CAU_THANH_TOAN = 2L;
        public static final Long HOP_DONG = 4L;
        public static final Long YEU_CAU_KIEM_TRA = 5L;
        public static final Long XU_LY_YEU_CAU_KIEM_TRA = 6L;
        public static final Long THAY_DOI_CHINH_SACH_HOA_HONG = 7L;
        public static final Long THONG_BAO = 8L;
    }

    public static class STATUS_NUM {

        public static final Long HIEU_LUC = 1L;
        public static final Long HET_HIEU_LUC = 0L;
    }

    public static class LEVEL_BONUS {

        public static final Long HOA_HONG_CAP_1 = 1L;
        public static final Long HOA_HONG_GIOI_THIEU = 2L;
        public static final Long TIEN_THANH_TOAN = 3L;
    }

    public static class SRC_CHANGE {

        public static final String WEB = "WEB: giao dịch thành công";
        public static final String JOB_SYNC = "JOB_SYNC: từ scheduled";
        public static final String DOI_SOAT = "DOI_SOAT: từ đối soát dl";
        public static final String THANH_TOAN = "THANH_TOAN: từ yêu cầu thanh toán";
    }

    public static class STATUS_TRANS {

        public static final Long THANH_CONG = 1L;
        public static final Long THAT_BAI = 0L;
    }

    public static class TRANS_TYPE {

        public static final int GOI_CUOC = 1;
        public static final int GAN_SO = 2;
        public static final int THANH_TOAN = 3;
    }

}
