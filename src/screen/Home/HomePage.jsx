import { Layout, Menu, Avatar, Button, Popover, message } from "antd";
import { Link, Outlet } from "react-router-dom";
import { useState, useEffect } from "react";
import { TOKEN } from "../../constant/APIConstant";
import { useNavigate } from "react-router-dom";
import {
  getGoogleUserInfo,
  getTokenGoogle,
  getUserService,
} from "../../service/API";
const items1 = [
  {
    id: 1,
    title: "Kênh người bán",
    to: "/seller/login",
  },
  {
    id: 2,
    title: "Đăng nhập",
    to: "/user/login",
  },
].map((key) => ({
  key: key.id,
  label: (
    <>
      <Link to={key.to} style={{ color: "white" }}>
        {key.title}
      </Link>
    </>
  ),
}));
const HomePage = () => {
  const [display, setDisplay] = useState("none");
  const [menuDisplay, setMenuDisplay] = useState("block");
  const [data, setData] = useState({});
  const navigate = useNavigate();
  const content = (
    <>
      <div>
        {data.userName}
        <Button
          onClick={() => {
            navigate("/account/profile");
          }}
          color="black"
          variant="link"
        >
          Tài khoản của tôi
        </Button>
      </div>
    </>
  );
  useEffect(() => {
    const url = new URL(window.location.href);
    const code = url.searchParams.get("code");
    if (code) {
      getTokenGoogle(url.href)
        .then((res) => {
          getGoogleUserInfo(res)
            .then((res) => {
              localStorage.setItem(TOKEN, res.token);
              navigate("/")
              window.location.reload()
              console.log(res);
            })
            .catch((err) => {
              console.log(err);
            });
        })
        .catch((err) => {
          console.log(err);
        });
    }
    const token = localStorage.getItem(TOKEN);
    if (token) {
      getUserService()
        .then((res) => {
          console.log(res);
          setData(res);
        })
        .catch(() => {
          navigate("/user/login");
          message.error("Phiên làm việc đã hết hạn");
          localStorage.removeItem(TOKEN);
        });
      setDisplay("block");
      setMenuDisplay("none");
    } else {
      setDisplay("none");
      setMenuDisplay("block");
    }
  }, []);

  return (
    <>
      <Layout.Header
        style={{
          display: "flex",
          alignItems: "center",
          background: "#ee4d2d",
          height: "40px",
        }}
      >
        <div style={{ display: menuDisplay }}>
          <div className="demo-logo" />
          <Menu
            theme="white"
            mode="horizontal"
            items={items1}
            style={{ flex: 1, minWidth: 0, color: "white" }}
          />
        </div>
        <div style={{ display: display }}>
          <Button
            onClick={() => {
              navigate("/register_seller");
            }}
            type="button"
            style={{ background: "#ee4d2d", color: "white" }}
            variant="solid"
          >
            Kênh người bán
          </Button>
          <Popover content={content}>
            <Avatar src={<img src={data.avatarProfile} alt="avatar" />} />
          </Popover>
          <Button
            onClick={() => {
              localStorage.removeItem(TOKEN);
              navigate("/");
              window.location.reload();
            }}
            type="button"
            style={{ background: "#ee4d2d", color: "white" }}
            variant="solid"
          >
            Đăng xuất
          </Button>
        </div>
      </Layout.Header>
      <Outlet context={data} />
    </>
  );
};

export default HomePage;
