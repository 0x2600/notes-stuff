// client.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <iostream>
#include <cstdio>
#include <WinSock2.h>
#pragma comment(lib, "ws2_32.lib")
int main()
{
    WSADATA wsaData;
    WSAStartup(MAKEWORD(2, 2), &wsaData);

    SOCKET clntSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

    sockaddr_in sockAddr;
    memset(&sockAddr, 0, sizeof(sockAddr));
    sockAddr.sin_family = PF_INET;
    sockAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    sockAddr.sin_port = htons(1234);
    printf("connecting...\n");
    connect(clntSock, (sockaddr*)&sockAddr, sizeof(sockaddr));

    char buf[1024] = { 0 };
    std::cout << "input str\n";
    std::string str;
    while (std::cin >> str)
    {
        send(clntSock, str.c_str(), str.size(), NULL);
        recv(clntSock, buf, sizeof(buf), NULL);
        printf("recved: %s\n", buf);
        memset(buf, 0, sizeof(buf));
        std::cout << "input str\n";
    }
    recv(clntSock, buf, sizeof(buf), NULL);
    printf("recved\n");
    printf(buf);
    closesocket(clntSock);


    WSACleanup();
    return 0;
}


