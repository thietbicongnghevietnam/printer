# Ứng Dụng Quản Lý Kho Thông Minh - Flutter

## Giới thiệu

Ứng dụng Quản Lý Kho Thông Minh là một ứng dụng di động phát triển bằng Flutter. Ứng dụng giúp quản lý kho, hàng tồn và sử dụng mã vạch để quét sản phẩm, đơn giản hóa quy trình nhập xuất kho.

## Tính năng

1. Receiving (Nhận Hàng)

   •	Good receipt have barcode: Nhận hàng có mã vạch. Người dùng có thể quét mã vạch để ghi nhận hàng hóa vào hệ thống.
   •	Good receipt no barcode: Nhận hàng không có mã vạch. Hàng hóa không có mã vạch sẽ được nhập tay vào hệ thống.
   •	Nhận hàng giao bù: Xử lý hàng giao bù trong trường hợp đơn hàng ban đầu bị thiếu hoặc lỗi.
   •	Xem Receiving Card: Cho phép người dùng xem thông tin chi tiết của phiếu nhận hàng (Receiving Card).
   •	Xem DA/Invoice: Xem thông tin chi tiết của hóa đơn (Invoice) hoặc đơn đặt hàng (DA) liên quan đến đợt nhận hàng.
   •	In lại Receiving Card: Tính năng cho phép in lại phiếu nhận hàng nếu cần thiết.
   •	Kiểm tra barcode thiếu: Kiểm tra xem có mã vạch nào bị thiếu trong quá trình nhận hàng không.
   •	In lại barcode NG: In lại mã vạch cho các sản phẩm bị lỗi hoặc không đạt tiêu chuẩn (NG - Not Good).

2. Temporary Area (Khu Vực Tạm Thời)

   •	Input location: Nhập vị trí tạm thời của hàng hóa khi chưa đưa vào kho chính thức.
   •	Move Receiving Card: Di chuyển phiếu nhận hàng (Receiving Card) từ khu vực tạm thời đến các vị trí khác hoặc kho chính.
   •	Out Receiving Card: Xuất phiếu nhận hàng ra khỏi khu vực tạm thời để chuẩn bị lưu kho hoặc sử dụng.

3. Storage (Kho Lưu Trữ)

   •	Lưu kho Receiving Card: Lưu trữ phiếu nhận hàng vào kho chính thức.
   •	Kiểm tra material trong kho: Kiểm tra tình trạng hàng hóa trong kho, bao gồm kiểm tra vị trí, số lượng, và tình trạng sản phẩm.
   •	Thay đổi vị trí lưu: Thay đổi vị trí lưu trữ của hàng hóa trong kho nếu cần thiết.
   •	Rời khỏi kho: Ghi nhận việc hàng hóa hoặc phiếu nhận hàng rời khỏi kho.
   •	Tách Receiving Card: Tách một phiếu nhận hàng thành nhiều phần nhỏ nếu cần chia nhỏ hàng hóa.
   •	IQC mượn Receiving Card: Bộ phận kiểm soát chất lượng (IQC) mượn phiếu nhận hàng để kiểm tra chất lượng sản phẩm.
   •	Tìm boxcard bị mất: Hỗ trợ tìm kiếm các mã vạch bị mất hoặc bị sai lệch.
   •	Stock to Receiving Card: Cập nhật thông tin tồn kho vào phiếu nhận hàng.
   •	Lưu kho Jupiter: Lưu trữ hàng hóa liên quan đến phiếu nhận hàng vào kho hệ thống Jupiter.
   •	Danh sách hàng gửi nhờ: Quản lý danh sách hàng hóa được gửi nhờ lưu trữ tại kho.

4. Kitting

   •	Kitting: Quản lý quá trình chuẩn bị các bộ linh kiện (kitting) để cung cấp cho dây chuyền sản xuất hoặc lắp ráp.
   •	Kitting Trolley: Quản lý việc chuẩn bị kitting trên xe đẩy (trolley) để tiện cho việc vận chuyển linh kiện đến các vị trí sản xuất.
   •	Find Kitting List: Tìm kiếm danh sách các bộ kitting theo yêu cầu.
   •	Check Kitting List: Kiểm tra danh sách các linh kiện đã chuẩn bị trong quá trình kitting.
   •	Supply: Cung cấp hoặc bổ sung linh kiện cho các khu vực sản xuất.
   •	Revert Kitting: Hoàn tác quá trình kitting nếu có lỗi hoặc cần thay đổi.
   •	Return Kitting: Trả lại linh kiện đã kitting về kho nếu không sử dụng.

5. Inventory (Kiểm Kê)

   •	Balance all: Kiểm tra và đối chiếu số lượng tồn kho toàn bộ các mặt hàng.
   •	Balance Receiving Card: Đối chiếu số lượng tồn kho với các phiếu nhận hàng.
   •	Check Receiving Card on Block: Kiểm tra các phiếu nhận hàng có nằm trong vị trí đó.

6. One for all

   •	Đây có thể là một tính năng chung để tổng hợp nhiều chức năng khác nhau trong hệ thống, giúp người dùng xử lý nhiều thao tác trong một màn hình hoặc luồng công việc hợp nhất.

### Cấu trúc thư mục

Dưới đây là cấu trúc dự án:

smart-warehouse/
├── android/               
│   └── # Thư mục cấu hình và mã nguồn liên quan đến ứng dụng Android.
├── assets/    
│   ├── html/                 # Chứa các tệp HTML tĩnh có thể được sử dụng trong ứng dụng.
│   ├── icons/                # Chứa các biểu tượng (icon) sử dụng trong giao diện người dùng.
│   ├── images/               # Chứa các hình ảnh được sử dụng trong ứng dụng.
│   ├── translators/          # Chứa các tệp ngôn ngữ phục vụ cho việc đa ngôn ngữ (localization).
├── ios/                   
│   └── # Thư mục cấu hình và mã nguồn liên quan đến ứng dụng iOS.
├── lib/                   
│   ├── di/                   # Chứa các tệp liên quan đến Dependency Injection (DI) giúp quản lý các dependency trong ứng dụng.
│   ├── entities/             # Chứa các class đại diện cho các đối tượng trong domain (Product, Order, User, v.v.).
│   ├── enums/                # Chứa các file enum dùng để định nghĩa các giá trị cố định như trạng thái nhận hàng, loại người dùng, v.v.
│   ├── gen/                  # Chứa các tệp được tự động sinh ra, ví dụ như các tệp code được sinh từ build_runner hoặc assets.
│   ├── repositories/         # Chứa các repository để truy xuất dữ liệu từ các nguồn (API, Database, v.v.).
│   ├── service/              # Chứa các dịch vụ hỗ trợ việc kết nối với backend và xử lý logic.
│   │   ├── interceptors/     # Chứa các interceptor giúp kiểm soát và điều chỉnh yêu cầu (request) và phản hồi (response) từ API.
│   │   ├── models/           # Chứa các model dữ liệu được sử dụng trong giao tiếp với API hoặc Database.
│   │   └── translators/      # Chứa các bộ chuyển đổi dữ liệu (translators) giữa các lớp dữ liệu khác nhau (ví dụ, từ DTO sang Entity).
│   │   └── api_services.dart # Cung cấp các dịch vụ API để giao tiếp với server hoặc các dịch vụ bên ngoài.
│   ├── shared/               # Chứa các thành phần được sử dụng chung trong toàn bộ ứng dụng.
│   │   ├── base/             # Các class cơ bản (base class) mà các phần khác của ứng dụng kế thừa.
│   │   ├── common/           # Chứa các tệp dùng chung như các component UI, mẫu code chung.
│   │   └── extensions/       # Các extension cho phép thêm chức năng vào các class mặc định của Dart/Flutter.
│   │   └── resources/        # Chứa các tài nguyên như kiểu chữ (font), màu sắc, style dùng trong UI.
│   │   └── router/           # Chứa logic định tuyến (routing) điều hướng giữa các màn hình.
│   │   └── utils/            # Các tiện ích và hàm hỗ trợ chung như xử lý chuỗi, định dạng thời gian.
│   │   └── constants.dart    # Chứa các hằng số được sử dụng trong toàn ứng dụng (API key, URL, v.v.).
│   ├── subsystems/           # Các hệ thống phụ của ứng dụng, có thể là các module độc lập hoặc các tính năng bổ sung.
│   ├── views/                # Chứa các màn hình giao diện người dùng (UI) của ứng dụng.
│   │   ├── dialogs/          # Chứa các hộp thoại (dialogs) tương tác với người dùng.
│   │   └── pages/            # Chứa các trang chính của ứng dụng.
│   │   └── sub_pages/        # Chứa các trang phụ hoặc các thành phần phụ của trang chính.
│   │   └── widgets/          # Chứa các widget tùy chỉnh sử dụng trong nhiều màn hình khác nhau.
│   ├── app.dart              # Tệp chính để khởi tạo và cấu hình ứng dụng.
│   ├── flavor_settings.dart  # Cấu hình cho các biến môi trường hoặc các phiên bản khác nhau của ứng dụng (ví dụ: staging, production).
│   └── main.dart             # Tệp chính khởi chạy ứng dụng.
├── test/                  
│   └── # Chứa các tệp kiểm thử đơn vị (unit test) cho từng phần của ứng dụng.
└── pubspec.yaml           
└── # Tệp cấu hình dự án Flutter, khai báo các gói (dependencies), assets và thông tin ứng dụng.

### Giải thích thêm

•	lib/: Đây là thư mục chính chứa mã nguồn của ứng dụng. Nó bao gồm các thành phần của kiến trúc Clean Architecture như entities, repositories, và các dịch vụ.
•	assets/: Chứa tài nguyên tĩnh như hình ảnh, biểu tượng và các tệp hỗ trợ khác như HTML hoặc các tệp dịch thuật (localization).
•	shared/: Được sử dụng để chứa các thành phần và tiện ích chung, giúp tái sử dụng và giữ mã nguồn sạch sẽ, dễ bảo trì.
•	service/: Chứa các dịch vụ như gọi API, xử lý dữ liệu, và tương tác với hệ thống bên ngoài.
•	views/: Chứa tất cả các thành phần giao diện người dùng (UI), bao gồm các trang, hộp thoại, và widget.
•	subsystems/: Có thể là các module hoặc hệ thống con, mỗi module này có thể là một tính năng độc lập hoặc chức năng bổ sung.

### 09.2026 gop IQC

## Cài đặt

### Yêu cầu hệ thống

- Flutter SDK 3.19.5
- Dart SDK 3.3.3
- Android Studio 

### Hướng dẫn cài đặt

1. Clone dự án từ repository:


2. Chuyển đến thư mục dự án:

   cd smart-warehouse-management

3. Cài đặt các gói phụ thuộc:

   flutter pub get

4. Tạo file đa ngôn ngữ

   flutter pub run easy_localization:generate -f keys -o locale_keys.dart -S assets/translations -O lib/shared/resources

5. Bạn cần chạy lệnh sau để tạo các file cần thiết:

flutter pub run build_runner build --delete-conflicting-outputs

6. Chạy ứng dụng:

   flutter run
